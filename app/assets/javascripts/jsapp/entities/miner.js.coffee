@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Miner extends Backbone.Model
    urlRoot: ->
      '/miners'

  class Entities.Miners extends Backbone.Collection
    model: Entities.Miner
    url: ->
      '/miners'

  App.reqres.setHandler "entities:miners", ->
    window.bit_return_miners ?= new App.Entities.Miners(gon.miners)
