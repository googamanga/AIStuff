class window.Brain extends Backbone.Model

  initialize: ->
    @set 'nodes', new Nodes()
    # @set 'connections', new Connections()

  mutateNodes:->
    @nodes.forEach (node) ->
      node.mutate()
