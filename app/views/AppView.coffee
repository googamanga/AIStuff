class window.AppView extends Backbone.View
  
  className: "AppView",

  initialize: ->
    # this.listenTo(@model, "change", @render);
    @render()

  render: ->
    $('body').append("hello")
    console.log('hello')