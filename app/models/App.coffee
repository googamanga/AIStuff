class window.App extends Backbone.Model

  initialize: ->
    @set 'environment', new Environment()
    @set 'judgments', {
      'eat'     : 5,
      'doNotEat': -5
    }
    @set 'count', 0
    @set 'intervalId', setInterval(@mainLoop, 1000/60, this)
    @set 'momsHealthPointsSum', 0

  findTheMom: (wannaBeMoms)->
          rand = Math.random() * @get('momsHealthPointsSum')
          sum = 0
          index = 0
          for agent in wannaBeMoms
            sum += agent.get('healthPoints')
            if sum >= rand
              return agent
            index += 1
          throw new Error 'rand not found in wannaBeMoms array'

  mainLoop: =>
    #spawn agents as needed
      #will change to agents spawning their own kids
    while @get('environment').get('populationLimit') > @get('environment').get('agents').length
       #wanna be moms exist, pick one and let it have it's baby
      wannaBeMoms = @get('environment').get('agents').filter (agent) =>
        if agent.get('wantsABaby')
         @set('momsHealthPointsSum',  (@get('momsHealthPointsSum') + agent.get('healthPoints')))
        else
          false
      if wannaBeMoms.length
        console.log('wannaBeMoms.length', wannaBeMoms)
        luckyOne = @findTheMom(wannaBeMoms)
        luckyOne.changeHealth(luckyOne.get('startingHealthPoints') * (-2))
        @get('environment').spawnAgent(luckyOne.pullEsseceInJSON())
        console.log("the lucky mom is ", luckyOne, "!")
      else #make a new naive one
        @get('environment').spawnAgent()
      @set('momsHealthPointsSum', 0)

    #while filtering on healthPoints, let agents act and judge them!
    # debugger
    deadAgents = @get('environment').get('agents').filter (agent) =>
      if agent.act() == 'eat'
        agent.changeHealth(@get('judgments').eat)
      else
        agent.changeHealth(@get('judgments').doNotEat)
      agent.incrimentAge()
      return  (agent.get('healthPoints') <= 0) or (agent.get('deathFromOldAge') == true)

    #cleanup dead agents

    console.log('dead agents length', deadAgents.length)
    if(deadAgents.length)
      console.log('removing deadAgnets', deadAgents)
    @get('environment').get('agents').remove(deadAgents)

    @set('count', @get('count') + 1)
    console.log('count:', @get('count'))
    @get('environment').get('agents').each (agent)->
      console.log('id: ', agent.cid,
                  'eat%: ', agent.get('linkProbs')[0],
                  'don\'eat%: ', agent.get('linkProbs')[1],
                  'healthpoints: ', agent.get('healthPoints'),
                  'age:', agent.get('age'),
                  'lastAction: ', agent.get('lastAction'))
    clearInterval(@get 'intervalId') if @get('count') >= 500

    #restart main loop









