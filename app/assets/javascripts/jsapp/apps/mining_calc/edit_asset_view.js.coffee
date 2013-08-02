@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.EditAssetView extends Marionette.ItemView
    template: "mining_calc/templates/edit_asset_view"
    onRender: ->
      #@$('.selectpicker').selectpicker()
      @$('.datepicker').datepicker
        showOtherMonths: true
        selectOtherMonths: true
        dateFormat: "d MM, yy"
        yearRange: "-1:+1"
