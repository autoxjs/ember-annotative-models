`import Ember from 'ember'`
`import _x from 'ember-autox-core/utils/xdash'`
`import _ from 'lodash/lodash'`
`import FieldFoundation from '../mixins/field-foundation'`

{computed: {match, apply, access}} = _x
{Object, computed} = Ember
{alias, or: ifAny} = computed
{noop} = _

TextType = /^string&(comment|note|body|description)/
DateType = /(date|moment|datetime)/
AttributeField = Object.extend FieldFoundation,
  typeName: computed "type", "name", ->
    {type, name} = @getProperties "type", "name"
    [type, name].join "&"
  prefix: match "typeName",
    ["string&email", -> "fa-at"],
    [TextType, -> "fa-comment-o"],
    [/^string&password/, -> "fa-lock"],
    [/^string/, -> "fa-pencil"],
    [/(price|cost|money)$/, -> "fa-money"],
    [DateType, -> "fa-calendar"],
    [/phone$/, -> "fa-mobile-phone"]
    [_, noop]
  componentName: match "typeName",
    [/^number/, -> "em-number-field"],
    ["string&email", -> "em-email-field"],
    [/^string&password/, -> "em-password-field"],
    [/^string&timezone/, -> "em-timezone-field"],
    [TextType, -> "em-textarea-field"],
    [DateType, -> "em-datetime-field"],
    [/^string/, -> "em-text-field"],
    [_, noop]
  presenter: alias "meta.options.presenter"

`export default AttributeField`