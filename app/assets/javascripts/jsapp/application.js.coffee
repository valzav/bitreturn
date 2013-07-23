@BitReturn = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on "initialize:before", (options) ->
    #window.user = App.request "set:current:user", options.user

  App.addRegions
    difficultyRegion: "#difficulty_region"
    assetsRegion: "#assets_region"
    returnRegion: "#return_region"

  App.addInitializer ->
    App.module('MiningCalcApp').start()

  App.on "initialize:after", (options) ->
    Backbone.history.start() if Backbone.history

  App

$(document).ready ->
  console.log 'document ready'