class window.Environment extends Backbone.Model

  initialize: ->
    @set 'populationLimit', 5
    @set 'agents', new Agents()

  spawnAgent: ->
    #takes in 0 parameters or an object with Agent some or all parameters
    #works-spawnAgent(Agent.pullEsseceInJSON())
    if @get('agents').length < @get('populationLimit')
      if arguments.length
        try
          essence = JSON.parse(arguments[0])
        catch e
          return @get('agents').add(arguments[0])
        return @get('agents').add(essence)
      else
        return @get('agents').add([{}])
    else
      console.log('reached population cap, dropped arguments:', arguments)
      undefined
