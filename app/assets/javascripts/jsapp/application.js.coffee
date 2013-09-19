@BitReturn = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on "initialize:before", (options) ->
    App.request "set:current:user", options.user

  App.addRegions
    userLoginCornerRegion: "#user_login_corner_region"
    difficultyRegion: "#difficulty_region"
    assetsRegion: "#assets_region"
    resultRegion: "#result_region"
    dialogRegion: Marionette.Region.Dialog.extend el: "#dialog_region"

  App.addInitializer ->
    App.module('MiningCalcApp').start()

  App.reqres.setHandler "default:region", ->
    App.assetsRegion

  App.on "initialize:after", (options) ->
    Backbone.history.start() if Backbone.history

  App

$(document).ready ->
  #console.log 'document ready'
