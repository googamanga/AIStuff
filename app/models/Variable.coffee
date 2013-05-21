class window.Variable extends Backbone.Model
  initialize: ->
    @set 'c', if arguments.length and arguments[0]['c'] then arguments[0]['c'] else 0.0000001  #default 100 times diff
    @set 'a', if arguments.length and arguments[0]['a'] then arguments[0]['a'] else 0.0001
    @set 'v', if arguments.length and arguments[0]['v'] then arguments[0]['v'] else 0.01
    @set 'd', if arguments.length and arguments[0]['d'] then arguments[0]['d'] else 1

  mutate: (distance, velocity, accelerate, constant)->
  	@set 'a', if accelerate
  	  accelerate - (@get 'c') /2 + Math.random()* (@get 'c')
  	else
      console.log('@c and accelerate must exist for @a to be set, @c:', (@get 'c'), ' accelearete:', accelerate)
      (@get 'a') - (@get 'c') /2 + Math.random()* (@get 'c')

    @set 'v', if velocity
      velocity - @get 'a' /2 + Math.random()* @get 'a'
    else
      console.log('@a and velocity must exist for @v to be set, @a:', (@get 'a'), ' velocity:', velocity)
      (@get 'v') - (@get 'a') /2 + Math.random()* (@get 'a')

    @set 'd', if distance
      distance - @get 'v' /2 + Math.random()* @get 'v'
    else
      console.log('@v and distance must exist for @d to be set, @v:', (@get 'v'), ' distance:', distance)
      (@get 'd') - (@get 'v') /2 + Math.random()* (@get 'v')
		