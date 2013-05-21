describe "AppView", ->
  appView = null
  app = null
  playerHand = null
  dealerHand = null

  beforeEach ->
    app = new App()
    appView = new AppView(model: app)
    playerHand = app.get('playerHand')
    dealerHand = app.get('dealerHand')
  describe "and App - ", ->
    it "after a game finishes the players are delt new deck", ->
      app.redeal()
      spyOn(appView, 'render')
      expect(app.get('deck').length).toEqual(48)
      expect(app.get('playerHand').length).toEqual(2)
      app.redeal()
      expect(app.get('deck').length).toEqual(48)
      expect(app.get('playerHand').length).toEqual(2)
    it "player hits he gets a card", ->
      expect(app.get('deck').length).toEqual(48)
      playerHand = app.get('playerHand')
      expect(playerHand.length).toEqual(2)
      spyOn(playerHand, 'scores').andReturn(15)
      playerHand.hit()
      expect(app.get('playerHand').length).toEqual(3)
      expect(app.get('deck').length).toEqual(47)
    it "dealer should hit after player has 19 and dealer has 18", ->
      spyOn(playerHand, 'scores').andReturn(19)
      spyOn(dealerHand, 'scores').andReturn(18)
      spyOn(dealerHand, 'hit')
      playerHand.stand()
      expect(dealerHand.hit).toHaveBeenCalled()
    it "dealer should win when player has 21 and dealer has 21", ->
      spyOn(playerHand, 'scores').andReturn(21)
      spyOn(dealerHand, 'scores').andReturn(21)
      playerHand.stand()
      expect(app.get('dealerWins')).toEqual(1)
      expect(app.get('playerWins')).toEqual(0)
    it "dealer should win when player has 23 and dealer has 22", ->
      spyOn(playerHand, 'scores').andReturn(23)
      spyOn(dealerHand, 'scores').andReturn(22)
      playerHand.stand()
      expect(app.get('dealerWins')).toEqual(1)
      expect(app.get('playerWins')).toEqual(0)