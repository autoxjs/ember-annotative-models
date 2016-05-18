`import Ember from 'ember'`
`import moment from 'moment'`
`import {getFieldCollection} from 'ember-annotative-models/utils/field-schema-engine'`
`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'game', 'Unit | Utility | field schema engine',
  needs: [
    'model:game'
    'model:app'
    'model:friend'
  ]

test "it should spit out the fields", (assert) ->
  gameParams =
    id: 9
    title: "Final Fantasy IX"
    esrbRating: "T"

  Ember.run =>
    store = @store()
    game = @subject gameParams
    gameFactory = store.modelFor "game"

    assert.ok store, "the store should be there"
    assert.ok game, "the game should be made"
    assert.equal game.id, 9, "the game should have the right id"
    assert.equal gameFactory.modelName, "game", "we should have the right factory"

    collectionClass = getFieldCollection gameFactory

    assert.ok collectionClass.create, "collections can be created"
    collection = collectionClass.create()
    assert.ok collection, "collections are created"

    fieldClasses = collectionClass.fieldClasses
    assert.ok fieldClasses, "we should have fieldClasses"
    assert.equal fieldClasses.get("length"), 4, "we have 4 fields"
    for fieldClass in fieldClasses
      assert.ok fieldClass.fieldName, "we should have field names"
      assert.ok fieldClass.create, "field classes should be createable"

    fields = fieldClasses.invoke "create"
    assert.ok fields
    assert.ok fields.sortBy, "fields should be sortable"
    sortedFields = fields.sortBy "priority"
    assert.equal sortedFields.get("length"), 4, "THERE ARE 4 LIGHTS"

    [aboutField, titleField, esrbField, progressField] = sortedFields.toArray()
    assert.ok aboutField, "aboutField should be there"
    assert.ok titleField, "titleField should be there"
    assert.ok esrbField, "esrbField should be there"
    assert.ok progressField, "progressField should be there"

    assert.equal aboutField.get("label"), "Game Unique Id",
      "aboutField should match the expected title"
    assert.equal titleField.get("label"), "Game Title",
      "titleField should match the expected title"
    assert.equal esrbField.get("label"), "ESRB Rating",
      "esrbField should match the expected title"
    assert.equal progressField.get("label"), "Installation Progression",
      "progressField should match the expected title"

    assert.equal titleField.get("type"), "string", "type of insert should be moment"
    assert.equal titleField.get("componentName"), "em-text-field"
    assert.deepEqual titleField.get("displayers"),
      ["model#index", "collection#index"],
      "the expected dispaly criteria should be present"

    titleField.initState
      model: game
      routeAction: "model#index"
    .then (fieldState) ->
      assert.equal fieldState.get("routeAction"), "model#index"
      assert.ok fieldState.get("canDisplay"), "the name field should be displayable"
      assert.notOk fieldState.get("canModify"), "the name field should not be modifyable"

    esrbField.initState
      model: game
      routeAction: "model#index"
    .then (fieldState) ->
      assert.notOk fieldState.get("canModify"), "esrb can't be modified"
      assert.ok fieldState.get("canDisplay"), "esrb can be displayed"
