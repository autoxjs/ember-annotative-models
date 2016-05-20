`import Ember from 'ember'`
`import getOwner from 'ember-getowner-polyfill'`
`import _ from 'lodash/lodash'`
{chain, bind} = _
{Object, isPresent, computed, isArray} = Ember

FieldsCollection = Object.extend
  priorityAsc: ["priority:asc"]
  sortedFields: computed.sort "fields", "priorityAsc"
  fields: computed "modelName", "fieldClasses", ->
    owner = getOwner @
    {modelName, fieldClasses} = @getProperties "modelName", "fieldClasses"
    Ember.assert "has model name", isPresent(modelName)
    nameBase = "field:#{modelName}"
    chain fieldClasses
    .tap (classes) -> Ember.assert "has field classes", isArray(classes)
    .tap (classes) -> Ember.assert "no shitty blank fields", classes.every isPresent
    .map (field) -> 
      chain(field.fieldName)
      .tap (name) -> Ember.assert "name should be present", isPresent name
      .value()
    .map (fieldName) -> nameBase + "/" + fieldName
    .map bind(owner.lookup, owner)
    .tap (fields) -> Ember.assert "should be a proper array", isArray(fields)
    .tap (fields) -> Ember.assert "all fields are registered", fields.every(isPresent)
    .value()

`export default FieldsCollection`