`import Ember from 'ember'`
`import DS from 'ember-data'`
`import {Core} from '../mixins/rich-model'`

initialize = ->
  return if Ember.get(DS.Model, "AnnotativeModelExtensionEnabled")
  DS.Model.reopenClass Core

RichModelExtensionInitializer =
  name: 'rich-model-extension'
  initialize: initialize

`export {initialize}`
`export default RichModelExtensionInitializer`
