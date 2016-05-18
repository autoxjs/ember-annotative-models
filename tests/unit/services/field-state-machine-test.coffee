`import { moduleFor, test } from 'ember-qunit'`

moduleFor 'service:field-state-machine', 'Unit | Service | field state machine', {
  # Specify the other units that are required for this test.
  # needs: ['service:foo']
}

# Replace this with your real tests.
test 'it exists', (assert) ->
  service = @subject()
  assert.ok service
