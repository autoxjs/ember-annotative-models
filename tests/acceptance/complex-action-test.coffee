`import Ember from 'ember'`
`import { test } from 'qunit'`
`import moduleForAcceptance from '../../tests/helpers/module-for-acceptance'`

moduleForAcceptance 'Acceptance: ComplexAction'

test 'visiting /', (assert) ->
  visit '/'
  andThen ->
    
