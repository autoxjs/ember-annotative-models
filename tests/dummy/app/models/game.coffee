`import Ember from 'ember'`
`import {Importance, about, action} from 'ember-annotative-models'`
`import DS from 'ember-data'`
{computed: {lt, gte}} = Ember
Game = DS.Model.extend
  title: DS.attr "string",
    label: "Game Title"
    priority: Importance.VeryImportant
    display: ["show", "index"]
    modify: ["edit", "new"]

  esrbRating: DS.attr "string",
    label: "ESRB Rating"
    description: "According to US law, games are to be rated from E to A"
    among: ["E", "T", "M", "A"]
    priority: Importance.Important
    display: ["show"]
    modify: ["edit", "new"]

  installProgress: DS.attr "number",
    label: "Installation Progression"
    description: """The installation progress is a number between 0 and 100
     where 0 means the game has not even been downloaded,
     and 100 is fully installed and ready to go
    """
    priority: Importance.Important
    between: [0, 100]
    display: ["show", "index"]
    modify: ["edit", "new"]

  install: action "click",
    label: "Install Game"
    description: "Begin or continue installation of this game (increments progress by 10%)"
    priority: Importance.MissionCritical
    display: ["show"]
    when: lt "installProgress", 100
    ->
      @incrementProperty "installProgress", 10
      yield return @save()

  uninstall: action "click",
    label: "Uninstall Game"
    description: "Uninstalls the game (that is, returns install progress back to 0)"
    priority: Importance.MissionCritical
    display: ["show"]
    when: gte "installProgress", 100
    ->
      @set "installProgress", 0
      yield return @save()

  socialLaunch: action "click",
    label: "Invite Friend to Play"
    description: "Invite a friend to play this game with you"
    priority: Importance.MissionCritical
    display: ["show"]
    when: gte "installProgress", 100
    ->
      friend = yield action.needs "friend"
      friend.set "currentlyPlaying", @get "title"
      friend.save()
about Game,
  label: "Game Unique Id"
  description: "An unique number assigned to your game"
  priority: Importance.VeryImportant
`export default Game`
