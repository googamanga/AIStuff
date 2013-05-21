class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
  hit: ->
    card = @deck.pop()
    @add(card)
    if @scores() > 21
      console.log('triggered bust')
      @trigger 'bust'
    else
      @trigger 'hit'
    card

  stand: ->
    console.log('triggered stand')
    @trigger 'stand'

  bust: ->
    console.log('triggered bust')
    @trigger 'bust'

  scores: ->
    hasAce = @reduce (memo, card) ->
      if card.get('revealed')
        memo or card.get('value') is 1
      else
        memo
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    arrayScore = if hasAce then [score, score + 10] else [score]
    if arrayScore.length == 2 and arrayScore[1] <= 21
    then return  arrayScore[1]
    arrayScore[0]
