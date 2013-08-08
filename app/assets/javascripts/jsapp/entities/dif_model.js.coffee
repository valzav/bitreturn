@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DifModel extends Backbone.Model
    urlRoot: ->
      '/dif_models'
    toJSON: ->
      monthly_growth: @attributes.monthly_growth
      investment_horizon: @attributes.investment_horizon
      usd_btc_rate: @attributes.usd_btc_rate
      cur_speed: @attributes.cur_speed
      cur_difficulty: @attributes.cur_difficulty
