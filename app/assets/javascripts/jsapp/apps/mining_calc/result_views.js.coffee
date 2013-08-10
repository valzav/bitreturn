@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.ResultView extends App.Views.ItemView
    template: 'mining_calc/result_view'
