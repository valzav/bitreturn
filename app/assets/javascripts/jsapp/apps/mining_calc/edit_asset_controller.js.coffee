@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  MiningCalcApp.EditAssetController =

    edit: (asset) ->
      console.log '---'
      editView = new MiningCalcApp.EditAssetView model: asset
      editView.on "dialog:button:clicked", ->
        console.log "editView instance dialog:button:clicked"
      App.dialogRegion.show editView
