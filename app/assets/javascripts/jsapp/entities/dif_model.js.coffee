@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DifModel extends Backbone.Model
    url: ->
      if @isNew() then "/dif_models" else "/dif_model/#{@id}"
    toJSON: ->
      dif_model:
        monthly_growth: @attributes.monthly_growth
        investment_horizon: @attributes.investment_horizon
        usd_btc_ticker: @attributes.usd_btc_ticker
        cur_speed: @attributes.cur_speed
        cur_difficulty: @attributes.cur_difficulty
