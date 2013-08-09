@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.ResultView extends Marionette.ItemView
    template: 'mining_calc/result_view'
