class window.Brain extends Backbone.Model

  initialize: ->
    @set'nodes', new Nodes()

  mutateNodes:->
    @nodes.forEach (node) ->
      node.mutate()
