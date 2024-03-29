@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  hashesFormatter = (v, axis) ->
    v.toFixed(axis.tickDecimals) + " (Th/s)"

  difficultyFormatter = (v, axis) ->
      v.toFixed(axis.tickDecimals) + " (M)"

  doPlot = (market) ->
    $.plot "#difficulty_chart", [
      data: market.get('data_hashes')
      label: "Network Speed (Th/s)"
      yaxis: 1
    ,
      data: market.get('data_difficulty')
      label: "Difficulty (M)"
      yaxis: 2
    ,
      data: market.get('data_f_hashes')
      label: "Network Speed Forecast (Th/s)"
      yaxis: 1
    ,
      data: market.get('data_f_difficulty')
      label: "Difficulty Forecast (M)"
      yaxis: 2
    ],
      xaxes: [
        mode: "time"
      ]
      yaxes: [
        min: 18.173
        tickFormatter: hashesFormatter
      ,
        min: 2.968775
        alignTicksWithAxis: 1
        position: "right"
        autoscaleMargin: 0.07
        tickFormatter: difficultyFormatter
      ]
      legend:
        position: "nw"

  MiningCalcApp.DifficultyController =

    show: ->
      @model = new App.Entities.MarketEnv(gon.market)
      @model.on 'change', @marketChanged
      @view = new MiningCalcApp.DifficultyView model: @model
      @view.on 'show', ->
        $('#investment_horizon').selectpicker()
        doPlot(@model)
      App.difficultyRegion.show @view

    marketChanged: ->
      unless window.model_is_saving
        window.save_model @, null, (model) ->
          doPlot(model)
          App.vent.trigger "market:changed", model

