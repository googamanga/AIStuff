beforeEach ->
  matchers = toBeBetween: (center, range) ->
    actual = @actual
    notText = if @isNot then " not" else ""
    @message = ->
      return "Expected " + actual + notText + " to be between " + (center - range/2) + " and " + (center + range/2)
    return ((center - range/2) < actual < (center + range/2)) and (actual isnt center)

  @addMatchers matchers

describe "variable", ->
  variable = null
  beforeEach ->
    variable = new Variable()
  afterEach ->
    variable = null

  it "should create a varable correctly", ->
    expect(variable).toBeDefined()
    expect(variable.get('c')).toEqual(1e-7)
    expect(variable.get('a')).toEqual(0.0001) 
    expect(variable.get('v')).toEqual(0.01)
    expect(variable.get('d')).toEqual(1)

  it "should create a varable correctly when overriding defaults", ->
    variable1 = new Variable( {'d': 4, 'v': 3, 'a': 2 , 'c': 1} )
    expect(variable1.get('c')).toEqual(1)
    expect(variable1.get('a')).toEqual(2) 
    expect(variable1.get('v')).toEqual(3)
    expect(variable1.get('d')).toEqual(4)

  it "should mutate a varable correctly", ->
    expect(variable.mutate).toBeDefined()
    expect(variable.get('c')).toEqual(1e-7)
    expect(variable.get('a')).toEqual(0.0001)
    expect(variable.get('v')).toEqual(0.01)
    expect(variable.get('d')).toEqual(1)
    variable.mutate()
    expect(variable.get('a')).toBeBetween(0.0001, 1e-7)
    expect(variable.get('v')).toBeBetween(0.01, 0.0001)
    expect(variable.get('d')).toBeBetween(1, 0.01)
describe "node", ->
  node = null
  beforeEach ->
    node = new Node()
  afterEach ->
    node = null
  it "should be defined when created", ->
    expect(node).toBeDefined()
    expect(node.get('position')).toBeDefined()
    expect(node.get('type')).toBeDefined()
  it "should be initialized", ->
    node.get('position')[0].mutate()
    node.get('position')[1].mutate()
    node.get('position')[0].get('d')
    expect(node.get('position')[0].get('d')).toBeBetween(1, 0.01)
    expect(node.get('position')[1].get('d')).toBeBetween(1, 0.01)
    expect(node.get('type')).toEqual('regular')
  it "should update position with parameters", ->
    node1 = new Node({'position': [new Variable({'d': 2, 'v': 3}), new Variable({'d': 3})]})
    node1.get('position')[0].mutate()
    node1.get('position')[1].mutate()
    expect(node1.get('position')[0].get('d')).toBeBetween(2, 3)
    expect(node1.get('position')[1].get('d')).toBeBetween(3, 0.01)
  it "should update type with parameter", ->
    node1 = new Node({'type': 'sensor'})
    expect(node1.get('type')).toEqual('sensor')














