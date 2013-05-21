#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: =>#which of these is sending the command (dealer)
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'playerScore', null
    @set 'playerWins', 0
    @set 'dealerHand', deck.dealDealer()
    @set 'dealerScore', null
    @set 'dealerWins', 0
    @bindListeners()

  bindListeners: =>
    @get('playerHand').on("stand bust", @dealerLogic)
    @get('dealerHand').on("hit", @dealerLogic)
    @get('dealerHand').on("stand bust", @checkWhoWins)

  dealerLogic: =>
    console.log('dealerLogic')
    if @get('dealerHand').at(0).get('revealed') == false then @get('dealerHand').at(0).flip()
    @dealerScore = @get('dealerHand').scores()
    console.log(@dealerScore)
    @playerScore = @get('playerHand').scores()
    console.log(@playerScore)
    console.log("dealer score:", @dealerScore, "player score:", @playerScore)
    if @dealerScore <= 17
      console.log('dealer hits')
      @get('dealerHand').hit()
    else if @dealerScore <= 21 and @playerScore > @dealerScore
      console.log('dealer hits')
      @get('dealerHand').hit()
    else
      console.log 'dealer stands'
      @get('dealerHand').stand()


  checkWhoWins: =>
    console.log('checking who won')
    if @playerScore > 21
      @dealerWins()
    else if @dealerScore <= 21 and @playerScore >= 21
      console.log(1)
      @dealerWins()
    else if @playerScore <= 21 and @dealerScore > 21
      console.log(2)
      @playerWins()
    else if @dealerScore >= @playerScore
      console.log(3)
      @dealerWins()
    else
      @playerWins()

  dealerWins: =>
    @set('dealerWins', @get('dealerWins')+1)
    console.log 'Dealer WINS!'
    console.log("dealer score:", @dealerScore, "player score:", @playerScore)
    console.log("dealerWins: ", @get('dealerWins'), ", playerWins:", @get('playerWins'))
    setTimeout @redeal, 2000

  playerWins: =>
    @set('playerWins', @get('playerWins')+1)
    console.log 'Player WINS!'
    console.log("dealer score:", @dealerScore, "player score:", @playerScore)
    console.log("dealerWins: ", @get('dealerWins'), ", playerWins:", @get('playerWins'))
    setTimeout @redeal, 2000

  redeal: =>
    console.log('redeal')
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @bindListeners()


