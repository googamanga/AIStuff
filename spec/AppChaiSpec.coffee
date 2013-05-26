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

describe "connection", ->
  connection = null
  beforeEach ->
    # connection = new Connection()
  afterEach ->
    connection = null
  it "should be defined when created"
    # expect(connection).to.exist
  it "should define sourceNode"
    # expect(connection.get('sourceNode')).to.exist
  it "should define targetNode"
    # expect(connection.get('targetNode')).to.exist
  it "should define connectionStrength"
    # expect(connection.get('connectionStrength')).to.exist
  it "should define sourceNode"
    # expect(connection.get('sourceNode')).to.exist


describe "node", ->
  node = null
  beforeEach ->
    node = new Node()
  afterEach ->
    node = null
  it "should be defined when created", ->
    expect(node).to.exist
    expect(node.get('position')).to.exist
    expect(node.get('type')).to.exist
  it "should be initialized", ->
    node.get('position')[0].get('d')
    expect(node.get('position')[0].get('d')).is.above(1-0.01).and.below(1+0.01).and.is.not.equal(1)
    expect(node.get('position')[1].get('d')).is.above(1-0.01).and.below(1+0.01).and.is.not.equal(1)
    expect(node.get('type')).to.equal('regular')
  it "should update position with parameters", ->
    node1 = new Node({'position': [new Variable({'d': 5, 'v': 3}), new Variable({'d': 3})]})
    expect(node1.get('position')[0].get('d')).is.above(5-3).and.below(5+3).and.is.not.equal(5)
    expect(node1.get('position')[1].get('d')).is.above(3-0.01).and.below(3+0.01).and.is.not.equal(3)
  it "should update position when only one parameter given", ->
    # node2 = new Node({'position': [new Variable({'d': 6, 'v': 1})]})
    # expect(node2.get('position')[0].get('d')).is.above(6-1).and.below(6+1).and.is.not.equal(6)
    # expect(node2.get('position')[1].get('d')).is.above(1-0.01).and.below(1+0.01).and.is.not.equal(1)
  it "should update type with parameter", ->
    node1 = new Node({'type': 'sensor'})
    expect(node1.get('type')).to.equal('sensor')
  it "should mutate position variables using node.mutate", ->
    pos0 = node.get('position')[0].get('d')
    pos1 = node.get('position')[0].get('d')
    node.mutate()
    expect(node.get('position')[0].get('d')).is.not.equal(pos0)
    expect(node.get('position')[1].get('d')).is.not.equal(pos1)
  it 'should have just x and y and not position'
  it "should be able to create custom variables with JSON, will be needed for persistanse later"

describe "nodes", ->
  nodes = null
  beforeEach ->
    nodes = new Nodes()
  afterEach ->
    nodes = null
  it "should be defined when created", ->
    expect(nodes).to.exist
    expect(nodes.length).to.exist
  it "should be able to add default", ->
    expect(nodes.add({}).length).to.equal(1)
    expect(nodes.at(0).get('position')[1].get('d')).is.above(1-0.01).and.below(1+0.01).and.is.not.equal(1)
    expect(nodes.at(0).get('type')).is.equal('regular');
  it "should be able to add several non-default nodes", ->
    nodes.add([{},{'type': 'sensor'}])
    expect(nodes.length).is.equal(2)
    expect(nodes.at(1).get('type')).is.equal('sensor');
  it "should be able to create custom variables with JSON, will be needed for persistanse later"

describe "Brain", ->
  brain = null
  beforeEach ->
    brain = new Brain()
  afterEach ->
    brain = null
  it "should be defined when created", ->
    expect(brain).to.exist
  it "should be able to create multiple nodes", ->
    brain.get('nodes').add({}) for node in [1..5]
    expect(brain.get('nodes').length).to.equal(5)
  it "shold be able to create multiple custom nodes", ->
    brain.get('nodes').add(node) for node in [{}, {'type': 'sensor'}, {}]
    expect(brain.get('nodes').length).is.equal(3)
    expect(brain.get('nodes').at(1).get('type')).is.equal('sensor')
  it "should be able to create custom variables with JSON, will be needed for persistanse later"


















