`import Ember from 'ember'`
`import {getFieldCollection} from '../utils/field-schema-engine'`
`import _ from 'lodash/lodash'`

{partial, partialRight, chain} = _
{get, String, isPresent, isArray} = Ember
registerField = (application, modelSpace, fieldClass) ->
  Ember.assert "needs modelSpace", isPresent(modelSpace)
  Ember.assert "needs fieldClass fieldName", isPresent(fieldClass?.fieldName)
  name = "field:#{modelSpace}/#{String.dasherize fieldClass.fieldName}"
  application.register name, fieldClass
  application.__container__.lookup name

registerCollection = (application, modelSpace, fieldCollection) ->
  Ember.assert "needs modelSpace", isPresent(modelSpace)
  application.register "field:#{modelSpace}", fieldCollection
  application.__container__.lookup "field:#{modelSpace}"

initialize = (application) ->
  container = if application.lookup? then application else application.__container__
  container
  .lookup "router:main"
  .one "willTransition", ->
    store = container.lookup("service:store")
    routeData = container.lookup("service:route-data")
    for modelName, _unused of routeData.instance().models
      chain store.modelFor(modelName)
      .thru getFieldCollection
      .thru partial(registerCollection, application, modelName)
      .get "constructor.fieldClasses"
      .tap (classes) -> Ember.assert "should be array of fields", isArray(classes)
      .value()
      .map partial(registerField, application, modelName)
      .map (field) -> Ember.assert "fields should be properly registered", isPresent field

FieldSchemaEngineInitializer =
  name: 'field-schema-engine'
  initialize: initialize

`export {initialize}`
`export default FieldSchemaEngineInitializer`
