class window.God extends Backbone.Model

  initialize: ->
    @set 'env', new Environment()
    @set 'judgments', {
      'eat'     : +5,
      'doNotEat': -5
    }
    @set 'count', 0
    # will need this later
    # env.spawnAgent() while env.get('populationLimit') <= env.get('agents').length
    @set 'intervalId', setInterval(@mainLoop, 0, this)


  mainLoop: =>
    #spawn agents as needed
      #will change to agents spawning their own kids
    @get('env').spawnAgent() while @get('env').get('populationLimit') > @get('env').get('agents').length

    #while filtering on healthPoints, let agents act and judge them!
    # debugger
    deadAgents = @get('env').get('agents').filter (agent) =>
      if agent.act == 'eat'
        agent.addHealth(@get('judgments').eat)
      else
        agent.subtractHealth(@get('judgments').doNotEat)
      return  agent.get('healthPoints') <= 0
    #cleanup dead agents
    @get('env').get('agents').remove(deadAgents)

    @set('count', @get('count') + 1)
    console.log('count:', @get('count'), 'agents:', @get('env').get('agents'))
    clearInterval(@get 'intervalId') if @get('count') == 100

    #restart main loop