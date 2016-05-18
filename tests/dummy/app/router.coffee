`import Ember from 'ember'`
`import config from './config/environment'`
`import DSL from 'ember-polymorphica/utils/dsl'`
Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  { namespace, model, child, children, view, form, collection } = DSL.import(@).with()

  namespace "dashboard", ->
    collection "games", ->
      form "new"
      model "game"
    collection "apps", ->
      model "app"
    collection "friends", ->
      form "add"
      model "friend"

`export default Router`
