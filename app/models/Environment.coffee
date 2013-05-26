class window.Environment extends Backbone.Model

  initialize: ->
    @set 'Agents', new Agents()
    