class window.Brain extends Backbone.Model

  initialize: ->
    #hardcoded action nodes
    #eat [0], don't eat[1]
    #set seeFoodConnectionUtility
    if arguments.length and arguments[0]['seeFoodConnectionUtility']
      try
        @set 'seeFoodConnectionUtility', [new Variable(arguments[0]['seeFoodConnectionUtility'][0]), new Variable(arguments[0]['seeFoodConnectionUtility'][1])]
      catch error
        console.log(error, "can't @set seeFoodConnectionUtility inside: ", this)
    else
      @set 'seeFoodConnectionUtility', [new Variable(), new Variable()]

    #seeFoodConnectionProbabilities
    probability = 1 / @get('seeFoodConnectionUtility').length
    @set 'seeFoodConnectionProbabilities', [probability, probability]
    @updateProbability()
    @set 'healthPoints', if arguments.length and arguments[0]['healthPoints'] then arguments[0]['healthPoints'] else 20

  mutate: ->
    @get('seeFoodConnectionUtility')[0].mutate()
    @get('seeFoodConnectionUtility')[1].mutate()
    @updateProbability()

  updateProbability: ->
    minUtil = Math.min(@get('seeFoodConnectionUtility')[0].get('d'), @get('seeFoodConnectionUtility')[1].get('d')) # keeps probs from being negative
    rawProbAndUtil0 = @get('seeFoodConnectionProbabilities')[0]+
      @get('seeFoodConnectionUtility')[0].get('d') +
      if minUtil < 0 then -minUtil else 0
    rawProbAndUtil1 = @get('seeFoodConnectionProbabilities')[1] +
      @get('seeFoodConnectionUtility')[1].get('d') +
      if minUtil < 0 then -minUtil else 0
    sumOfRawProbAndUtil = rawProbAndUtil0 + rawProbAndUtil1
    @set 'seeFoodConnectionProbabilities', [rawProbAndUtil0 / sumOfRawProbAndUtil, rawProbAndUtil1 / sumOfRawProbAndUtil]

  addHealth: (num) ->
    @set 'healthPoints', (@get('healthPoints') + num)

  subtractHealth: (num) ->
    @set 'healthPoints', (@get('healthPoints') - num)

  act: ->  #later will become (senseNode, with some magnitued parameter)
    rand = Math.random()
    sum = 0
    index = 0
    @mutate()
    for connectionStrenght in @get('seeFoodConnectionProbabilities')
      sum += connectionStrenght
      if sum >= rand
        return if index == 0 then 'eat' else 'do not eat'
      index += 1
    throw new Error 'rand not found in connection Strength array for \'seeFoodConnectionProbabilities\''



