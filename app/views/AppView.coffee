class window.AppView extends Backbone.View
  
  className: "AppView"

  initialize: ->
    @render()


  render: ->
    $('body').append($("<p>hello</p>").outerHtml)
    # $('body').append("hello")