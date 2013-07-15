jQuery ->
  hashesFormatter = (v, axis) ->
    v.toFixed(axis.tickDecimals) + " (GHash/s)"

  doPlot = ->
    jQuery.plot "#chart_div", [
      data: gon.data_hashes
      label: "Hashes (GHash/s)"
      yaxis: 1
    ,
      data: gon.data_difficulty
      label: "Difficulty"
      yaxis: 2
    ,
      data: gon.data_f_hashes
      label: "Forecast Hashes (GHash/s)"
      yaxis: 1
    ,
      data: gon.data_f_difficulty
      label: "Forecast Difficulty"
      yaxis: 2
    ],
      xaxes: [
        mode: "time"
      ]
      yaxes: [
        min: 18173
        tickFormatter: hashesFormatter
      ,
        min: 2968775
        alignTicksWithAxis: 1
        position: "right"
        autoscaleMargin: 0.07
      ]
      legend:
        position: "nw"

  data = gon.data



  doPlot()
