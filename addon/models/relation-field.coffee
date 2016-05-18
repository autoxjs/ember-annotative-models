`import Ember from 'ember'`
`import FieldFoundation from '../mixins/field-foundation'`
`import _x from 'ember-autox-core/utils/xdash'`
`import _ from 'lodash/lodash'`

{identity} = _
{computed: {apply}} = _x
{RSVP, Object, computed: {oneWay, alias}} = Ember

RelationField = Object.extend FieldFoundation,
  proxyKey: apply "meta.options.proxyKey", (key) -> key ? "id"

`export default RelationField`
