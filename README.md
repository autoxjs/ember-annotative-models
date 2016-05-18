# Ember-annotative-models

Introduces the concept of fields to models and allows for extremely annotative models

automatically registers fields based upon the models you have declared in your routes

## Dependencies
```sh
ember-concurrency
ember-autox-core
ember-lodash
ember-router-dsl
```
Because actions use es6 generators, be sure to include that in the polyfill
```javascript
var EmberAddon = require('ember-cli/lib/broccoli/ember-addon');

module.exports = function(defaults) {
  var app = new EmberAddon(defaults, {
    babel: { includePolyfill: true }
  });

  return app.toTree();
};
```

## Installation

* `git clone` this repository
* `npm install`
* `bower install`

## Running

* `ember server`
* Visit your app at http://localhost:4200.

## Running Tests

* `npm test` (Runs `ember try:testall` to test your addon against multiple Ember versions)
* `ember test`
* `ember test --server`

## Building

* `ember build`

For more information on using ember-cli, visit [http://ember-cli.com/](http://ember-cli.com/).
