@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  hashesFormatter = (v, axis) ->
    v.toFixed(axis.tickDecimals) + " (Th/s)"

  difficultyFormatter = (v, axis) ->
      v.toFixed(axis.tickDecimals) + " (M)"

  doPlot = (dm) ->
    $.plot "#difficulty_chart", [
      data: dm.get('data_hashes')
      label: "Network Speed (Thash/s)"
      yaxis: 1
    ,
      data: dm.get('data_difficulty')
      label: "Difficulty (M)"
      yaxis: 2
    ,
      data: dm.get('data_f_hashes')
      label: "Network Speed Forecast (Thash/s)"
      yaxis: 1
    ,
      data: dm.get('data_f_difficulty')
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

    spinnerChange: (event, ui) ->
      console.log '---------'

    show: ->
      @model = new App.Entities.DifModel(gon.dm)
      @model.on 'change', @difModelChanged
      console.log @model
      @view = new MiningCalcApp.DifficultyView model: @model
      @view.on 'show', ->
        $('#investment_horizon').selectpicker()
        doPlot(@model)
      App.difficultyRegion.show @view

    difModelChanged: ->
      #console.log this
      console.log "difModelChanged monthly_growth:#{@get('monthly_growth')}  investment_horizon:#{@get('investment_horizon')}"
      unless window.model_is_saving
        window.save_model @, null, (model) ->
          doPlot(model)

