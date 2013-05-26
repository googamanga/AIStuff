class window.Node extends Backbone.Model
  initialize: ->
    @set 'sourceNode'
    @set 'targetNode'
    @set 'connectionStrength'

  mutate: ->
    @get('position')[0].mutate()
    @get('position')[1].mutate()