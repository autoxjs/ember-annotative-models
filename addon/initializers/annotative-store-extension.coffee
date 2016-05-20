`import DS from 'ember-data'`
`import {Core} from '../mixins/annotative-store'`
initialize = ->
  return if Ember.get(DS.Store, "AnnotativeStoreExtensionEnabled")
  DS.Store.reopenClass AnnotativeStoreExtensionEnabled: true
  DS.Store.reopen Core

AnnotativeStoreExtensionInitializer =
  name: 'annotative-store-extension'
  initialize: initialize

`export {initialize}`
`export default AnnotativeStoreExtensionInitializer`
