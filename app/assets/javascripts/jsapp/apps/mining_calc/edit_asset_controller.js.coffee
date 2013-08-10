@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  MiningCalcApp.EditAssetController =

    edit: (asset) ->
      editView = new MiningCalcApp.EditAssetView model: asset
      formView = App.request "form:wrapper", editView
      editView.on "form:submit", (data) ->
        console.log data
        formView.trigger 'dialog:close'
        return false
      App.dialogRegion.show formView
