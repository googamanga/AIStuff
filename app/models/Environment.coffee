class window.Environment extends Backbone.Model

  initialize: ->
    @set 'populationLimit', 5
    @set 'agents', new Agents()

  spawnAgent: ->
    if @get('agents').length < @get('populationLimit')
      if arguments.length
        @get('agents').add(arguments[0])
      else @get('agents').add([{}])
    else
      undefined