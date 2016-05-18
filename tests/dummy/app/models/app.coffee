`import {Importance, about, action} from 'ember-annotative-models'`
`import DS from 'ember-data'`

App = DS.Model.extend
  name: DS.attr "string",
    label: "Display Name"
    display: ["show", "index"]
    modify: ["new", "edit"]
    priority: Importance.VeryImportant

  summary: DS.attr "string",
    label: "App Description"
    description: "A short one-sentence description of what this app does"
    display: ["show"]
    modify: ["new", "edit"]
    priority: Importance.Important

  iconImage: DS.attr "string",
    description: "This is preferrably png img src that will be used in the tile cards"
    display: ["show", "index"]
    modify: ["new", "edit"]
    priority: Importance.Important

  launch: action "click",
    label: "Launches Application"
    description: "Loads the application and handles over control to it"
    display: ["show"]
    priority: Importance.MissionCritical
    ->
      @set "isLaunched", true
      yield return

about App,
  label: "App Name"
  description: "Apps are addons to the system which extend functionality; apps can be downloaded in the app store"

`export default App`
