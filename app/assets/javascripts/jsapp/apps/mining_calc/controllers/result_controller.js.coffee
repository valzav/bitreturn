@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  doPlot = (cashflows) ->
    $.plot "#result_chart", [
      data: cashflows
      label: "Cashflow"
      yaxis: 1
    ],
      xaxes: [
        mode: "time"
      ]
      yaxes: [
        min: 0
      ]
      legend:
        position: "nw"

  MiningCalcApp.ResultController =

    show: (result) ->
      @model = result
      @layout = new MiningCalcApp.ResultLayout
      @layout.on 'show', =>
        @showAssetsRegion(@model)
        @showSummaryRegion(@model)
        @showChartRegion(@model)
      App.resultRegion.show @layout

    showAssetsRegion: (model) ->
      view = new MiningCalcApp.ResultAssetsListView model: model
      view.on 'current:ar:changed', (r) =>
        m = if r then r else model
        @showSummaryRegion(m)
        @showChartRegion(m)
      @layout.assetsListRegion.show view

    showSummaryRegion: (model) ->
      view = new MiningCalcApp.ResultSummaryView model: model
      @layout.summaryRegion.show view

    showChartRegion: (model) ->
      view = new MiningCalcApp.ResultChartView model: model
      view.on 'show', ->
        doPlot(model.get('cashflows'))
      @layout.chartRegion.show view
