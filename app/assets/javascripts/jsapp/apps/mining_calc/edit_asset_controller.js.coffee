@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  MiningCalcApp.EditAssetController =

    edit: (asset) ->
      asset = App.request "new:asset:entity" unless asset
      assets = App.request "assets:entities"
      editView = new MiningCalcApp.EditAssetView model: asset, collection: assets
      formView = App.request "form:wrapper", editView
      App.dialogRegion.show formView
