@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.ResultLayout extends App.Views.Layout
    template: 'mining_calc/result_layout'
    regions:
      assetsListRegion: "#result_assets_list_region"
      summaryRegion: "#result_summary_region"
      chartRegion: "#result_chart_region"

  class MiningCalcApp.ResultAssetsListView extends App.Views.ItemView
    template: 'mining_calc/result_assets_list_view'
    events:
      'click tr.asset' : 'asset_result_selected'
    asset_result_selected: (e) ->
      row = $(e.currentTarget)
      row.addClass('active').siblings().removeClass('active')
      r = @model.get_ar(row.data('asset-id'))
      @trigger('current:ar:changed', r)


  class MiningCalcApp.ResultSummaryView extends App.Views.ItemView
    template: 'mining_calc/result_summary_view'

  class MiningCalcApp.ResultChartView extends App.Views.ItemView
    template: 'mining_calc/result_chart_view'
