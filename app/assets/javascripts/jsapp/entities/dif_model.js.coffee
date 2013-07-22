@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DifModel extends Backbone.Model
    defaults:
      monthly_growth: 50
      investment_horizon: '01/01/2014'
    url: ->
      if @isNew() then "/dif_models" else "/dif_model/#{@id}"
    toJSON: ->
      dif_model: {monthly_growth: @attributes.monthly_growth, investment_horizon: @attributes.investment_horizon}
