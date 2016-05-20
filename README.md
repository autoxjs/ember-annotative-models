# Ember-annotative-models

Introduces the concept of fields to models and allows for extremely annotative models

automatically registers fields based upon the models you have declared in your routes

## Usage
Annotate your models like so:
```coffeescript
`import {Importance, about, action} from 'ember-annotative-models'`
`import DS from 'ember-data'`

Friend = DS.Model.extend
  username: DS.attr "string",
    label: "User Name"
    description: "The unique gamer handle on the Playstation Now Network"
    display: ["show", "index"]
    modify: ["new"]
    priority: Importance.Important

  currentlyPlaying: DS.attr "string",
    label: "Currently Playing"
    description: "The video game this friend is playing at this moment"
    display: ["show", "index"]
    modify: ["edit"]
    priority: Importance.Important

`export default Friend`
```
Access field via the store
```javascript
this.store.fieldsFor "friend"
```

## Dependencies
```sh
ember-concurrency
ember-autox-core
ember-lodash
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
