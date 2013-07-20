jQuery ->
  hashesFormatter = (v, axis) ->
    v.toFixed(axis.tickDecimals) + " (Th/s)"

  difficultyFormatter = (v, axis) ->
    v.toFixed(axis.tickDecimals) + " (M)"

  doPlot = ->
    jQuery.plot "#chart_div", [
      data: gon.data_hashes
      label: "Network Speed (Thash/s)"
      yaxis: 1
    ,
      data: gon.data_difficulty
      label: "Difficulty (M)"
      yaxis: 2
    ,
      data: gon.data_f_hashes
      label: "Network Speed Forecast (Thash/s)"
      yaxis: 1
    ,
      data: gon.data_f_difficulty
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

  data = gon.data



  doPlot()
