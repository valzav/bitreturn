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

    show: (result)->
      @model = result
      @view = new MiningCalcApp.ResultView model: @model
      @view.on 'show', ->
        doPlot(@model.get('cashflows'))
      @view.on 'current:ar:changed', (r) ->
        cashflows = if r then r.cashflows else @model.get('cashflows')
        doPlot(cashflows)
      App.resultRegion.show @view
