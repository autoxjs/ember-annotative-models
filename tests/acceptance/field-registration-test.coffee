`import Ember from 'ember'`
`import { test } from 'qunit'`
`import moduleForAcceptance from '../../tests/helpers/module-for-acceptance'`
`import getOwner from 'ember-getowner-polyfill'`
moduleForAcceptance 'Acceptance: FieldRegistration'

test 'visiting /', (assert) ->
  container = @application.__container__
  store = container.lookup("service:store")
  visit '/'
  andThen ->
    gameFields = store.fieldsFor "game"
    assert.ok gameFields, "fields collection should be there"

    fields = gameFields.get("fields")
    assert.ok fields, "the collection should have fields"
    assert.ok Ember.isArray(fields), "it should be an array"
    assert.equal fields.length, 7, "there should be seven fields"

    assert.ok getOwner(gameFields), "the collection object should have an owner"

    for field in fields
      assert.ok getOwner(field), "each field should have an owner"

    
