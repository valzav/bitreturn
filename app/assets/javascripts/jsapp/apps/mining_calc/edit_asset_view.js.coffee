@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.EditAssetView extends App.Views.ItemView
    template: "mining_calc/templates/edit_asset_view"
    events:
      'change #select_miner' : 'minerSelected'
    modelEvents:
      'change' : 'render'
    onRender: ->
      #@$('.selectpicker').selectpicker()
      @$('.datepicker').datepicker
        showOtherMonths: true
        selectOtherMonths: true
        dateFormat: "mm/dd/yy"
        yearRange: "-1:+1"
    minerSelected: (e)->
      miners = App.request "entities:miners"
      miner = miners.get(e.target.value)
      return unless miner
      @model.populateFromMiner(miner)
      console.log 'minerSelected', @model
