beforeEach ->
  matchers = toBeBetween: (center, range) ->
    actual = @actual
    notText = if @isNot then " not" else ""
    @message = ->
      return "Expected " + actual + notText + " to be between " + (center - range/2) + " and " + (center + range/2)
    return ((center - range/2) < actual < (center + range/2)) and (actual isnt center)

  @addMatchers matchers

describe "variable", ->
  variable = new Variable()

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
    console.log(variable.attributes)
    variable.mutate()
    console.log(variable.attributes)
    console.log('a', 0.0001 -  1e-7/2, 0.0001+ 1e-7/2)
    expect(variable.get('a')).toBeBetween(0.0001, 1e-7)
    console.log('v', 0.01 -  0.0001/2, 0.01+ 0.0001/2)
    expect(variable.get('v')).toBeBetween(0.01, 0.0001)
    console.log('d', 1 -  0.01/2, 1+ 0.01/2)
    expect(variable.get('d')).toBeBetween(1, 0.01)