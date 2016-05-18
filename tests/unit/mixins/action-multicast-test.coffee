`import Ember from 'ember'`
`import ActionMulticastMixin from 'ember-annotative-models/mixins/action-multicast'`
`import { module, test } from 'qunit'`

module 'Unit | Mixin | action multicast'

# Replace this with your real tests.
test 'it works', (assert) ->
  ActionMulticastObject = Ember.Object.extend ActionMulticastMixin
  subject = ActionMulticastObject.create()
  assert.ok subject
