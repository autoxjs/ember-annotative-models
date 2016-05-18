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
