class window.App extends Backbone.Model

  initialize: ->
    @set 'environment', new Environment()
    @set 'judgments', {
      'eat'     : 5,
      'doNotEat': -5
    }
    @set 'count', 0
    @set 'intervalId', setInterval(@mainLoop, 1000/60, this)
    @set 'parentsHealthPointsSum', 0

  findTheParent: (wannaBeParents)->
          rand = Math.random() * @get('parentsHealthPointsSum')
          sum = 0
          index = 0
          for agent in wannaBeParents
            sum += agent.get('healthPoints')
            if sum >= rand
              return agent
            index += 1
          throw new Error 'rand not found in wannaBeParents array'

  mainLoop: =>
    #spawn agents as needed
      #will change to agents spawning their own kids
    while @get('environment').get('populationLimit') > @get('environment').get('agents').length
       #wanna be parents exist, pick one and let it have it's baby
      wannaBeParents = @get('environment').get('agents').filter (agent) =>
        if agent.get('wantsABaby')
         @set('parentsHealthPointsSum',  (@get('parentsHealthPointsSum') + agent.get('healthPoints')))
        else
          false
      if wannaBeParents.length
        console.log('wannaBeParents.length', wannaBeParents)
        luckyOne = @findTheParent(wannaBeParents)
        luckyOne.changeHealth(luckyOne.get('startingHealthPoints') * (-2))
        console.log("the lucky parent is: ", luckyOne, "!")
        console.log("the lucky kid is: ", @get('environment').spawnAgent(luckyOne.pullEsseceInJSON()).at(@get('environment').get('agents').length-1))
      else #make a new naive one
        @get('environment').spawnAgent()
      @set('parentsHealthPointsSum', 0)

    #while filtering on healthPoints, let agents act and judge them!
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
    clearInterval(@get 'intervalId') if @get('count') >= 100

    #restart main loop









