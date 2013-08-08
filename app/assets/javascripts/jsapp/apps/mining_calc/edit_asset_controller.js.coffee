@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  MiningCalcApp.EditAssetController =

    edit: (asset) ->
      console.log '---'
      editView = new MiningCalcApp.EditAssetView model: asset

      #editView.on "dialog:button:clicked", ->
      #  console.log "editView instance dialog:button:clicked"
      formView = App.request "form:wrapper", editView
      editView.on "form:submit", (data) ->
        console.log data
        formView.trigger 'dialog:close'
        return false

      App.dialogRegion.show formView
