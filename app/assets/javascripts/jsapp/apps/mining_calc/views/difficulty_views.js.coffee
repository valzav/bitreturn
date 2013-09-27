@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.DifficultyView extends App.Views.Layout
    template: 'mining_calc/difficulty_view'

    events:
      'change #monthly_growth': 'monthly_growth_changed'
      'keyup #monthly_growth': 'monthly_growth_changed'
      'mouseup #monthly_growth': 'monthly_growth_changed'
      'change #investment_horizon': 'investment_horizon_changed'

    onRender: ->
      @$('#growth_rate_tooltip_goggle').tooltip(placement: 'right')

    monthly_growth_changed: (e) ->
      target = $(e.target)
      value = target.val()
      @model.set('monthly_growth', value) if(value > 0 and value < 300)

    investment_horizon_changed: (e) ->
      target = $(e.target)
      value = target.val()
      @model.set('investment_horizon', value) if(value > 0 and value < 100)
