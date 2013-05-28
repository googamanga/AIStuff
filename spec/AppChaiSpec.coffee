"use strict"
expect = chai.expect

describe 'Variable', ->
  variable = null
  beforeEach ->
    variable = new Variable()
  afterEach ->
    variable = null
  it "should create a varable correctly", ->
    expect(variable).to.exist
    expect(variable.get('c')).is.equal(0.0000001)
    expect(variable.get('a')).is.equal(0.0001)
    expect(variable.get('v')).is.equal(0.01)
    expect(variable.get('d')).is.equal(0.1)
    # expect(variable.get('a')).is.above(0.0001-0.0000001).and.below(0.0001+0.0000001).and.is.not.equal(0.0001)
    # expect(variable.get('v')).is.above(0.01-0.0001).and.below(0.01+0.0001).and.is.not.equal(0.01)
    # expect(variable.get('d')).is.above(0.05-0.01).and.below(0.05+0.01).and.is.not.equal(0.5)

  it "should create a varable correctly when overriding defaults", ->
    variable1 = new Variable( {'d': 4, 'v': 3, 'a': 2 , 'c': 1} )
    expect(variable1.get('c')).is.equal(1)
    expect(variable1.get('a')).is.equal(2)
    expect(variable1.get('v')).is.equal(3)
    expect(variable1.get('d')).is.equal(4)
    # expect(variable1.get('a')).is.above(2-1).and.below(2+1).and.is.not.equal(2)
    # expect(variable1.get('v')).is.above(3-2).and.below(3+2).and.is.not.equal(3)
    # expect(variable1.get('d')).is.above(4-3).and.below(4+3).and.is.not.equal(4)
  it "should be able to mutate", ->
    variable.mutate()
    expect(variable.get('a')).is.above(0.0001-0.0000001).and.below(0.0001+0.0000001).and.is.not.equal(0.0001)
    expect(variable.get('v')).is.above(0.01-0.0001).and.below(0.01+0.0001).and.is.not.equal(0.01)
    expect(variable.get('d')).is.above(0.1-0.01).and.below(0.1+0.01).and.is.not.equal(0.100)
  it "should be able to create custom variables with JSON, will be needed for persistanse later"

describe "Brain", ->
  describe "initialize", ->
    brain = null
    beforeEach ->
      brain = new Brain()
    afterEach ->
      brain = null
    it "should be defined when created", ->
      expect(brain).to.exist
    it "should create Health Points", ->
      expect(brain.get('healthPoints')).to.exist
      expect(brain.get('healthPoints')).is.equal(20)
    it "should create custom Health Points", ->
      brain1 = new Brain({'healthPoints': 100})
      expect(brain1.get('healthPoints')).is.equal(100)
    it "should add health points", ->
      brain.changeHealth(5)
      expect(brain.get('healthPoints')).is.equal(25)
    it "should subtract health points", ->
      brain.changeHealth(-5)
      expect(brain.get('healthPoints')).is.equal(15)

    describe "linkUtil", ->
      it "should create linkUtil Node", ->
        expect(brain.get('linkUtil')).to.exist
      it "should create linkUtil Node with variables", ->
        expect(brain.get('linkUtil')[0]).to.exist
      it "should create sensory node with variable", ->
        expect(brain.get('linkUtil')[0].get('d')).is.above(0.1-0.01).and.below(0.1+0.01).and.is.not.equal(0.1)
      it "should create sensory node with variable trough parameters", ->
        brain1 = new Brain({'linkUtil':[{'d': 4, 'v': 1},{'d': 6, 'v': 2}]})
        expect(brain1.get('linkUtil')[0].get('d')).is.above(4-1).and.below(4+1).and.is.not.equal(4)
        expect(brain1.get('linkUtil')[1].get('d')).is.above(6-2).and.below(6+2).and.is.not.equal(6)

    describe "linkProbs", ->
      it "should create linkProbs", ->
        expect(brain.get('linkProbs')).to.exist
      it "should create linkProbs with full parameters", ->
        brain2 = new Brain({'linkProbs':[0.2, 0.8]})
        expect(brain2.get('linkProbs')[0]).is.below(0.35)
        expect(brain2.get('linkProbs')[1]).is.above(0.65)
      it "should mutate Utility and Probabilities on mutate()", ->
        varU0 = brain.get('linkUtil')[0].get('d')
        varU1 = brain.get('linkUtil')[1].get('d')
        varP0 = brain.get('linkProbs')[0]
        varP1 = brain.get('linkProbs')[1]
        brain.mutate()
        expect(brain.get('linkUtil')[0].get('d')).is.not.equal(varU0)
        expect(brain.get('linkUtil')[1].get('d')).is.not.equal(varU1)
        expect(brain.get('linkProbs')[0]).is.not.equal(varP0)
        expect(brain.get('linkProbs')[1]).is.not.equal(varP1)

    describe "act", ->
      it "should work", ->
        expect(brain.act()).to.match(/^eat$|^do not eat$/)

describe "Environment", ->
  environment = null
  beforeEach ->
    environment = new Environment()
  afterEach ->
    environment = null
  it 'should exist', ->
    expect(environment).to.exist
  it 'should create agents', ->
    expect(environment.get('agents')).to.exist
  it 'should be able to use spawn with no params', ->
    spy = sinon.spy(environment, "spawnAgent")
    environment.spawnAgent()
    expect(spy.called).is.true
    expect(environment.get('agents').length).to.equal(1)
  describe 'spawn', ->
    agents = null
    beforeEach ->
      environment.spawnAgent({
        'linkUtil':[{'d': 0.1, 'v': 0.1},{'d': 0.1, 'v': 0.1}],
        'linkProbs': [0.1,0.9],
        'healthPoints': 25
        })
      agents = environment.get('agents')
    it 'should create new agent', ->
      expect(agents.length).to.equal(1)
    it 'should update healthPoints', ->
      expect(agents.at(0).get('healthPoints')).is.equal(25)
    it 'should update linkUtil', ->
      expect(agents.at(0).get('linkUtil')[0].get('d')).is.above(0.1-0.11).and.below(0.1+0.1).and.is.not.equal(0.1)
    it 'should update linkProbs', ->
      expect(agents.at(0).get('linkProbs')[0]).is.below(0.30)
      expect(agents.at(0).get('linkProbs')[1]).is.above(0.70)
    it 'should not create new agents after population cap', ->
      environment.spawnAgent() for index in [1..7]
      expect(agents.length).to.equal(5)
    it 'should be able to handle JSON string "spawnAgent(JSON.parse(Brain.pullEsseceInJSON()))"', ->
      environment.spawnAgent(JSON.parse(agents.at(0).pullEsseceInJSON()))
      expect(agents.length).to.equal(2)
      expect(agents.at(1).get('healthPoints')).is.equal(25)
      expect(agents.at(1).get('linkUtil')[0].get('d')).is.above(0.1-0.11).and.below(0.1+0.1).and.is.not.equal(0.1)
      expect(agents.at(1).get('linkProbs')[0]).is.below(0.35).and.is.not.equal(agents.at(0).get('linkProbs')[0])
      expect(agents.at(1).get('linkProbs')[1]).is.above(0.65).and.is.not.equal(agents.at(0).get('linkProbs')[1])
    it 'should be able to handle JSON string "spawnAgent(Brain.pullEsseceInJSON())"', ->
      environment.spawnAgent(agents.at(0).pullEsseceInJSON())
      expect(agents.length).to.equal(2)
      expect(agents.at(1).get('healthPoints')).is.equal(25)
      expect(agents.at(1).get('linkUtil')[0].get('d')).is.above(0.1-0.11).and.below(0.1+0.1).and.is.not.equal(0.1)
      expect(agents.at(1).get('linkProbs')[0]).is.below(0.35).and.is.not.equal(agents.at(0).get('linkProbs')[0])
      expect(agents.at(1).get('linkProbs')[1]).is.above(0.65).and.is.not.equal(agents.at(0).get('linkProbs')[1])
describe 'App', ->
  it 'should start', ->
    app = new App()





















