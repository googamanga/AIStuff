class window.Brain extends Backbone.Model

  initialize: ->
    #hardcoded action nodes
    #eat [0], don't eat[1]
    #set linkUtil
    if arguments.length and arguments[0]['linkUtil']
      try
        @set 'linkUtil', [new Variable(arguments[0]['linkUtil'][0]), new Variable(arguments[0]['linkUtil'][1])]
      catch error
        console.log(error, "can't @set linkUtil inside: ", this)
    else
      @set 'linkUtil', [new Variable(), new Variable()]

    #linkProbs
    if arguments.length and arguments[0]['linkProbs']
      # debugger
      @set 'linkProbs', [arguments[0]['linkProbs'][0], arguments[0]['linkProbs'][1]]
      try
        if ( arguments[0]['linkProbs'].reduce (memo, connection)-> (memo + connection) != 1) # if sum is not one
          throw new Error
      catch error
        console.log(error, "can't @set linkProbs inside: ", this)
    else
      probability = 1 / @get('linkUtil').length
      @set 'linkProbs', [probability, probability]

    @set 'healthPoints', if arguments.length and arguments[0]['healthPoints'] then arguments[0]['healthPoints'] else 20
    @set 'lastAction', null
    @mutate()

  mutate: ->
    @get('linkUtil')[0].mutate()
    @get('linkUtil')[1].mutate()
    @updateProbability()

  updateProbability: ->
    minUtil = Math.min(@get('linkUtil')[0].get('d'), @get('linkUtil')[1].get('d')) # keeps probs from being negative
    rawProbAndUtil0 = @get('linkProbs')[0]+
      @get('linkUtil')[0].get('d') +
      if minUtil < 0 then -minUtil else 0
    rawProbAndUtil1 = @get('linkProbs')[1] +
      @get('linkUtil')[1].get('d') +
      if minUtil < 0 then -minUtil else 0
    sumOfRawProbAndUtil = rawProbAndUtil0 + rawProbAndUtil1
    @set 'linkProbs', [rawProbAndUtil0 / sumOfRawProbAndUtil, rawProbAndUtil1 / sumOfRawProbAndUtil]

  addHealth: (num) ->
    @set 'healthPoints', (@get('healthPoints') + num)

  subtractHealth: (num) ->
    @set 'healthPoints', (@get('healthPoints') - num)

  pullEsseceInJSON: ->
    JSON.stringify this

  act: ->  #later will become (senseNode, with some magnitued parameter)
    rand = Math.random()
    sum = 0
    index = 0
    @mutate()
    for connectionStrenght in @get('linkProbs')
      sum += connectionStrenght
      if sum >= rand
        action = if index == 0 then 'eat' else 'do not eat'
        @set 'lastAction', action
        return action
      index += 1
    throw new Error 'rand not found in connection Strength array for \'linkProbs\''



