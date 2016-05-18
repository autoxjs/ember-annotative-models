`import Ember from 'ember'`
`import _x from 'ember-autox-core/utils/xdash'`
`import FieldState from '../states/field-state'`

{A, isPresent, inject, RSVP, computed: {map, alias, and: ifAll, or: ifAny, not: none}} = Ember
{computed: {apply, match}} = _x
formalize = (x) ->
  switch x
    when "show" then "model#index"
    when "edit" then "model#edit"
    when "new", "index" then "collection##{x}"
    else x
FieldFoundationMixin = Ember.Mixin.create
  fsm: inject.service "field-state-machine"
  rouetData: inject.service "route-data"

  accessName: ifAny "aliasKey", "name"
  aliasKey: alias "meta.options.aliasKey"
  type: alias "meta.type"
  label: ifAny "meta.options.label", "name"
  step: alias "meta.options.step"
  relationKind: alias "meta.kind"

  priority: ifAny "meta.options.priority", "defaultPriority"
  defaultPriority: 1
  description: alias "meta.options.description"
  
  displayers: map "meta.options.display", formalize
  modifiers: map "meta.options.modify", formalize

  isRelationship: alias "meta.isRelationship"
  isAttribute: alias "meta.isAttribute"
  isVirtual: alias "meta.isVirtual"
  isAction: alias "meta.isAction"
  isLink: ifAll "isRelationship", "meta.options.link"
  isBasic: none "among"
  among: alias "meta.options.among"
  defaultValue: alias "meta.options.defaultValue"

  presenter: alias "meta.options.presenter"
  accessor: alias "meta.options.accessor"
  isCustomForm: apply "accessor", (accessor) -> isPresent(accessor) and typeof accessor is "string"
  isCustomized: apply "presenter", (presenter) -> isPresent(presenter) and typeof presenter is "string"
  
  getWhen: -> @get("meta.options")?.when ? true
  initState: (ctx) ->
    FieldState
    .extend
      when: @getWhen()
    .create {ctx, content: @}
    .preload()

`export default FieldFoundationMixin`