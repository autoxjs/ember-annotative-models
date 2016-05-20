`import Ember from 'ember'`
`import AttributeField from '../models/attribute-field'`
`import ActionField from '../models/action-field'`
`import RelationField from '../models/relation-field'`
`import _ from 'lodash/lodash'`
`import FieldsCollectionBase from '../models/fields-collection'`
{A, Object, computed, isPresent, isArray, inject, String} = Ember
{chain, tap, partial, merge, partialRight, invoke} = _

reEx = (baseClass, core) ->
  extClass = baseClass.extend(core)
  extClass.reopenClass
    fieldName: core.name
  extClass

aboutMeDefault = (factory) ->
  label: "#{factory.modelName} id"
  description: "#{factory.modelName} objects are resourceful representations of data"
  display: ["show", "index"]

getIdField = (factory, fields) ->
  aboutMe = merge aboutMeDefault(factory), factory.aboutMe
  meta =
    type: "string"
    options: aboutMe
  fields.pushObject reEx(AttributeField, {meta, name: "id"})

getAttributeFields = (factory, fields) ->
  factory.eachAttribute (name, meta) ->
    fields.pushObject reEx(AttributeField, {name, meta})

getRelationshipFields = (factory, fields) ->
  factory.eachRelationship (name, meta) ->
    fields.pushObject reEx(RelationField, {name, meta})

getVirtualFields = (factory, fields) ->
  factory.eachVirtualAttribute? (name, meta) ->
    fields.pushObject reEx(AttributeField, {name, meta})

getActionFields = (factory, fields) ->
  factory.eachActionAttribute? (name, meta) ->
    fields.pushObject reEx(ActionField, {name, meta})

getFields = (factory) ->
  chain A()
  .tap partial getIdField, factory
  .tap partial getAttributeFields, factory
  .tap partial getRelationshipFields, factory
  .tap partial getVirtualFields, factory
  .tap partial getActionFields, factory
  .value()

getFieldCollection = (factory) ->
  FieldsCollectionBase.extend
    modelName: factory.modelName
    fieldClasses: getFields(factory)

`export {getFields, getFieldCollection, getActionFields, getVirtualFields, getAttributeFields, getIdField, aboutMeDefault}`