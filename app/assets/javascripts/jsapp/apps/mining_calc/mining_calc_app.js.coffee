@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class MiningCalcApp.Router extends Marionette.AppRouter
    appRoutes:
      "": "index"

  API =
    index: ->
      console?.log '---> route API.index'
      MiningCalcApp.DifficultyController.show()

  MiningCalcApp.on 'start', ->
    console?.log 'Starting MiningCalcApp module'
    new MiningCalcApp.Router controller: API
    App.addInitializer ->
      console?.log "Initializing MiningCalcApp"
      #Entities = App.module('Entities')
      #@coupon = new Entities.Coupon(gon.coupon)

  App.on "initialize:after", (options)->
    #@navigate('new', trigger: true) if @getCurrentRoute() is ''

