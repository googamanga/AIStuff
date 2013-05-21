class window.Node extends Backbone.Model
  initialize: ->
    @set 'id'
    @set 'connectedTo'
    @set 'position'

  defaults: {
    'connectedTo': null,
    #connectedTo: {nodeId: newVariable()}
    #'position': [new Variable(), new Variable()]

  }