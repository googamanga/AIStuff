class window.Variable extends Backbone.Model
  initialize: ->
    @set 'c', if arguments.length and arguments[0]['c'] then arguments[0]['c'] else 0.0000001  #default 100 times diff
    @set 'a', if arguments.length and arguments[0]['a'] then arguments[0]['a'] else 0.0001
    @set 'v', if arguments.length and arguments[0]['v'] then arguments[0]['v'] else 0.01
    @set 'd', if arguments.length and arguments[0]['d'] then arguments[0]['d'] else 0.05
    @mutate()

  mutate: (distance, velocity, accelerate, constant)->
    @set 'a', if accelerate
        accelerate - (@get 'c') /2 + Math.random()* (@get 'c')
      else
        (@get 'a') - (@get 'c') /2 + Math.random()* (@get 'c')

    @set 'v', if velocity
        velocity - @get 'a' /2 + Math.random()* @get 'a'
      else
        (@get 'v') - (@get 'a') /2 + Math.random()* (@get 'a')

    @set 'd', if distance
        distance - @get 'v' /2 + Math.random()* @get 'v'
      else
        (@get 'd') - (@get 'v') /2 + Math.random()* (@get 'v')
