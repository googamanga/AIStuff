assert = chai.assert
expect = chai.expect
should = chai.should() # Note that should has to be executed

describe 'variable', ->
  variable = null
  beforeEach ->
    variable = new Variable()
  afterEach ->
    variable = null
  it "should create a varable correctly", ->
    expect(variable).to.exist
    expect(variable.get('a')).is.above(0.0001-0.0000001).and.below(0.0001+0.0000001).and.is.not.equal(0.0001)
    expect(variable.get('v')).is.above(0.01-0.0001).and.below(0.01+0.0001).and.is.not.equal(0.01)
    expect(variable.get('d')).is.above(1-0.01).and.below(1+0.01).and.is.not.equal(1)

  it "should create a varable correctly when overriding defaults and mutate a varable correctly", ->
    variable1 = new Variable( {'d': 4, 'v': 3, 'a': 2 , 'c': 1} )
    expect(variable1.get('c')).is.equal(1)
    expect(variable1.get('a')).is.above(2-1).and.below(2+1).and.is.not.equal(2)
    expect(variable1.get('v')).is.above(3-2).and.below(3+2).and.is.not.equal(3)
    expect(variable1.get('d')).is.above(4-3).and.below(4+3).and.is.not.equal(4)
  it "should be able to create custom variables with JSON, will be needed for persistanse later"

describe "Brain", ->
  brain = null
  beforeEach ->
    brain = new Brain()
  afterEach ->
    brain = null
  it "should be defined when created", ->
    expect(brain).to.exist
  it "should create sensory Node", ->
    expect(brain.get('seeFoodNode')).to.exist
  it "should create sensory node with variable", ->
    expect(brain.get('seeFoodNode')[0].get('d')).is.above(1-0.01).and.below(1+0.01).and.is.not.equal(1)
  it "should create sensory node with variable trough parameters", ->
    brain1 = new Brain({'seeFoodNode':[{'d': 4, 'v': 1},{'d': 6, 'v': 2}]})
    expect(brain1.get('seeFoodNode')[0].get('d')).is.above(4-1).and.below(4+1).and.is.not.equal(4)
    expect(brain1.get('seeFoodNode')[1].get('d')).is.above(6-2).and.below(6+2).and.is.not.equal(6)
  it "should mutate connections on mutate()", ->
    var0 = brain.get('seeFoodNode')[0].get('d')
    var1 = brain.get('seeFoodNode')[1].get('d')
    brain.mutate()
    expect(brain.get('seeFoodNode')[0].get('d')).is.not.equal(var0)
    expect(brain.get('seeFoodNode')[1].get('d')).is.not.equal(var1)
  it "should create Health Points", ->
    expect(brain.get('healthPoints')).to.exist
    expect(brain.get('healthPoints')).is.equal(20)
  it "should create custom Health Points", ->
    brain1 = new Brain({'healthPoints': 100})
    expect(brain1.get('healthPoints')).is.equal(100)
  it "should add health points", ->
    brain.addHealth(5)
    expect(brain.get('healthPoints')).is.equal(25)
  it "should subtract health points", ->
    brain.subtractHealth(5)
    expect(brain.get('healthPoints')).is.equal(15)

















