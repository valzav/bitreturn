@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  today = new Date()
  in_a_week = new Date(today.getTime() + (7 * 24 * 60 * 60 * 1000))

  class Entities.Asset extends Entities.Model
    defaults:
      purchase_date: $.datepicker.formatDate("mm/dd/yy", today)
      effective_date: $.datepicker.formatDate("mm/dd/yy", in_a_week)
    urlRoot: ->
      '/assets'
    populateFromMiner: (miner)->
      m = miner.toJSON()
      @set
        name: m.name
        price: m.price
        currency: m.currency
        price_display: m.price_display
        ghps: m.ghps
        power_use_watt: m.power_use_watt
        quantity: 1
        assetable_id: m.id

  class Entities.Assets extends Entities.Collection
    model: Entities.Asset
    url: ->
      '/assets'

  App.reqres.setHandler "new:asset:entity", ->
    new Entities.Asset

  App.reqres.setHandler "assets:entities", ->
    window.bit_return_assets ?= new App.Entities.Assets(gon.assets)
