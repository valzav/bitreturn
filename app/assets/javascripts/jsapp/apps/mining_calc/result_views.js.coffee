@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.ResultView extends App.Views.ItemView
    template: 'mining_calc/result_view'
    events:
      'click tr.asset' : 'asset_result_selected'

    asset_result_selected: (e) ->
      row = $(e.currentTarget)
      row.addClass('active').siblings().removeClass('active')
      r = @model.get_ar(row.data('asset-id'))
      @trigger('current:ar:changed', r)
