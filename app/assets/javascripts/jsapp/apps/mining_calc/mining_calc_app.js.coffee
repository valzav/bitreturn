@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class MiningCalcApp.Router extends Marionette.AppRouter
    appRoutes:
      "": "index"

  API =
    index: ->
      console?.log '---> route API.index'
      MiningCalcApp.UserController.showUserLoginCorner()
      MiningCalcApp.DifficultyController.show()
      MiningCalcApp.AssetsController.show()
      MiningCalcApp.ResultController.show(new App.Entities.AnalysisResult(gon.result))
    edit: (asset) ->
      MiningCalcApp.EditAssetController.edit asset
    showCreateAccountDialog: (user) ->
      MiningCalcApp.UserController.showCreateAccountDialog user
    refreshResult: ->
      result = new App.Entities.AnalysisResult()
      result.on 'created', (r) ->
        MiningCalcApp.ResultController.show(r)
      result.save()

  MiningCalcApp.on 'start', ->
    console?.log 'Starting MiningCalcApp module'
    App.miners = App.request "entities:miners"

    assets = App.request "assets:entities"
    assets.on 'model:created model:updated remove', API.refreshResult

    new MiningCalcApp.Router controller: API
    App.addInitializer ->
      console?.log "Initializing MiningCalcApp"

  App.vent.on "asset:edit:clicked", (asset) ->
    API.edit(asset)

  App.vent.on "market:changed", (market_env) ->
    API.refreshResult()

  resetTimer = ->
    clearTimeout(timeout) if window.timeout
    window.timeout = setTimeout( ->
      clearTimeout(timeout)
      $(document).prop('onmousemove', null)
      $(document).prop('onclick', null)
      API.showCreateAccountDialog()
    , 5*60*1000)

  startTimer = ->
    unless window.user.hasAccount()
      document.onmousemove = resetTimer
      document.onclick = resetTimer
      resetTimer()

  App.on "initialize:after", (options)->
    startTimer()
