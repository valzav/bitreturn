@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  MiningCalcApp.EditAssetController =

    edit: (asset) ->
      asset = App.request "new:asset:entity" unless asset
      assets = App.request "assets:entities"
      editView = new MiningCalcApp.EditAssetView model: asset, collection: assets
#      editView.on 'miner:selected',  (args, e)->
#        console.log '--- minerSelected', args, e

      formView = App.request "form:wrapper", editView
#      editView.on "form:submit", (data) ->
#        #console.log data
#        formView.trigger 'dialog:close'
#        true
      App.dialogRegion.show formView
