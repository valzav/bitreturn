@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  doPlot = (result) ->
    $.plot "#result_chart", [
      data: result.get('cashflows')
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

    show: ->
      @model = new App.Entities.AnalysisResult(gon.result)
      @view = new MiningCalcApp.ResultView model: @model
      @view.on 'show', ->
        console.log '-----ResultView show'
        doPlot(@model)
      App.resultRegion.show @view
