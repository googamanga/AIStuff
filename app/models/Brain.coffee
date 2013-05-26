class window.Brain extends Backbone.Model

  initialize: ->
    if arguments.length and arguments[0]['seeFoodNode']
      try
        @set 'seeFoodNode', [new Variable(arguments[0]['seeFoodNode'][0]), new Variable(arguments[0]['seeFoodNode'][1])]
      catch error
        console.log(error, "can't @set seeFoodNode inside: ", this)
    else
      @set 'seeFoodNode', [new Variable(), new Variable()]
    @mutate()
    @set 'healthPoints', if arguments.length and arguments[0]['healthPoints'] then arguments[0]['healthPoints'] else 20

  mutate: ->
    @get('seeFoodNode')[0].mutate()
    @get('seeFoodNode')[1].mutate()

  addHealth: (num) ->
    @set 'healthPoints', (@get('healthPoints') + num)

  subtractHealth: (num) ->
    @set 'healthPoints', (@get('healthPoints') - num)


