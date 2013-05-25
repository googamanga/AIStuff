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
    expect(variable.get('c')).to.equal(1e-7)
    expect(variable.get('a')).to.equal(0.0001) 
    expect(variable.get('v')).to.equal(0.01)
    expect(variable.get('d')).to.equal(1)

  it "should create a varable correctly when overriding defaults", ->
    variable1 = new Variable( {'d': 4, 'v': 3, 'a': 2 , 'c': 1} )
    expect(variable1.get('c')).to.equal(1)
    expect(variable1.get('a')).to.equal(2) 
    expect(variable1.get('v')).to.equal(3)
    expect(variable1.get('d')).to.equal(4)

  it "should mutate a varable correctly", ->
    expect(variable.mutate).to.exist
    expect(variable.get('c')).to.equal(1e-7)
    expect(variable.get('a')).to.equal(0.0001)
    expect(variable.get('v')).to.equal(0.01)
    expect(variable.get('d')).to.equal(1)
    variable.mutate()
    expect(variable.get('a')).is.above(0.0001-1e-7/2).and.below(0.0001+1e-7/2).and.is.not.equal(0.0001)
    expect(variable.get('v')).is.above(0.01-0.0001/2).and.below(0.01+0.0001/2).and.is.not.equal(0.01)
    expect(variable.get('d')).is.above(1-0.01/2).and.below(1+0.01/2).and.is.not.equal(1)

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
    node.get('position')[0].mutate()
    node.get('position')[1].mutate()
    node.get('position')[0].get('d')
    expect(node.get('position')[0].get('d')).is.above(1-0.01/2).and.below(1+0.01/2).and.is.not.equal(1)
    expect(node.get('position')[1].get('d')).is.above(1-0.01/2).and.below(1+0.01/2).and.is.not.equal(1)
    expect(node.get('type')).to.equal('regular')
  it "should update position with parameters", ->
    node1 = new Node({'position': [new Variable({'d': 5, 'v': 3}), new Variable({'d': 3})]})
    node1.get('position')[0].mutate()
    node1.get('position')[1].mutate()
    expect(node1.get('position')[0].get('d')).is.above(5-3/2).and.below(5+3/2).and.is.not.equal(5)
    expect(node1.get('position')[1].get('d')).is.above(3-0.01/2).and.below(3+0.01/2).and.is.not.equal(3)
  it "should update type with parameter", ->
    node1 = new Node({'type': 'sensor'})
    expect(node1.get('type')).to.equal('sensor')
  it "should mutate position variables using node.mutate", ->
    expect(node.get('position')[0].get('d')).is.equal(1)
    expect(node.get('position')[1].get('d')).is.equal(1)
    node.mutate()
    expect(node.get('position')[0].get('d')).is.above(1-0.01/2).and.below(1+0.01/2).and.is.not.equal(1)
    expect(node.get('position')[1].get('d')).is.above(1-0.01/2).and.below(1+0.01/2).and.is.not.equal(1)

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
    expect(nodes.at(0).get('position')[1].get('d')).is.equal(1);
    expect(nodes.at(0).get('type')).is.equal('regular');
  it "should be able to add several non-default nodes", ->
    nodes.add([{},{'type': 'sensor'}])
    expect(nodes.length).is.equal(2)
    expect(nodes.at(1).get('type')).is.equal('sensor');










