class window.Brain extends Backbone.Model

  initialize: ->
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


