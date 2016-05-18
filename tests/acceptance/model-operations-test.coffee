`import Ember from 'ember'`
`import { test } from 'qunit'`
`import moduleForAcceptance from '../../tests/helpers/module-for-acceptance'`

moduleForAcceptance 'Acceptance: ModelOperations'

test 'visiting /', (assert) ->
  container = @application.__container__
  assert.ok container, "we should have the container"
  store = container.lookup "service:store"
  visit '/'

  andThen ->
    game = store.createRecord "game",
     title: "Applepicker"
     esrbRating: "E"
     installProgress: 0

    game.save()
    .then ->
      assert.ok game.get("id"), "the id should be ok"
      assert.equal game.get("title"), "Applepicker",
        "title should match"
      assert.equal game.get("esrbRating"), "E",
        "rating should match"
      assert.equal game.get("installProgress"), 0,
        "progress should match"
      game.set "title", "Kiwicatcher"
      game.set "esrbRating", "T"
      game.save()
    .then ->
      assert.equal game.get("title"), "Kiwicatcher",
        "title should have changed"
      assert.equal game.get("esrbRating"), "T",
        "rating should have changed"
      store.findAll "game"
    .then (games) ->
      assert.ok games.get("firstObject"), "we shold have bunch of games"
