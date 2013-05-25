
class window.Node extends Backbone.Model
  initialize: ->
    #position: [Var x, Var y]
    @set 'position': if arguments.length and arguments[0]['position'] then arguments[0]['position'] else [new Variable, new Variable]
    #type: sensor, action, regular
    @set 'type': if arguments.length and arguments[0]['type'] then arguments[0]['type'] else 'regular'

  mutate: ->
    @get('position')[0].mutate()
    @get('position')[1].mutate()