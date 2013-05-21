class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    console.log('new Deck')
    @add _(_.range(1, 53)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> hand = new Hand [ @pop(), @pop() ], @

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, true
