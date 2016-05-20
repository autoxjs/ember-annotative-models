`import Ember from 'ember'`
`import {getFieldCollection} from '../utils/field-schema-engine'`
`import _ from 'lodash/lodash'`
`import getOwner from 'ember-getowner-polyfill'`

{partial, partialRight, chain} = _
{get, String, isPresent, isArray} = Ember

registerField = (owner, modelSpace, fieldClass) ->
  Ember.assert "needs modelSpace", isPresent(modelSpace)
  Ember.assert "needs fieldClass fieldName", isPresent(fieldClass?.fieldName)
  name = "field:#{modelSpace}/#{String.dasherize fieldClass.fieldName}"
  owner.register name, fieldClass

registerCollection = (owner, modelSpace, fieldCollectionClass) ->
  Ember.assert "needs modelSpace", isPresent(modelSpace)
  owner.register "field:#{modelSpace}", fieldCollectionClass
  owner.lookup "field:#{modelSpace}"

registerIndividualFields = (owner, modelSpace, fieldCollectionInstance) ->
  fieldCollectionInstance
  .get("fieldClasses")
  .map partial(registerField, owner, modelSpace)

registerFields = (factory, owner) ->
  fieldCollection = chain factory
  .thru getFieldCollection
  .thru partial(registerCollection, owner, factory.modelName)
  .tap partial(registerIndividualFields, owner, factory.modelName)
  .value()

Core =
  fieldsFor: (modelName) ->
    owner = getOwner @
    Ember.assert "We have an owner", isPresent(owner)
    return fields if (fields = owner.lookup "field:#{modelName}")
    registerFields @modelFor(modelName), owner

AnnotativeStore = Ember.Mixin.create Core
`export {Core}`
`export default AnnotativeStore`