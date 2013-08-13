@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class MiningCalcApp.Router extends Marionette.AppRouter
    appRoutes:
      "": "index"

  API =
    index: ->
      console?.log '---> route API.index'
      MiningCalcApp.DifficultyController.show()
      MiningCalcApp.AssetsController.show()
      MiningCalcApp.ResultController.show()
    edit: (asset) ->
      MiningCalcApp.EditAssetController.edit asset

  MiningCalcApp.on 'start', ->
    console?.log 'Starting MiningCalcApp module'
    App.miners = App.request "entities:miners"
    new MiningCalcApp.Router controller: API
    App.addInitializer ->
      console?.log "Initializing MiningCalcApp"
      #Entities = App.module('Entities')
      #@coupon = new Entities.Coupon(gon.coupon)

  App.vent.on "asset:edit:clicked", (asset) ->
    API.edit(asset)

  App.vent.on "asset:new:clicked", ->
    API.edit(null)

  App.on "initialize:after", (options)->
    #@navigate('new', trigger: true) if @getCurrentRoute() is ''

