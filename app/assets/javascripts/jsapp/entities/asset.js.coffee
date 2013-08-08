@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  today = new Date()
  in_a_week = new Date(today.getTime() + (7 * 24 * 60 * 60 * 1000))

  class Entities.Asset extends Backbone.Model
    defaults:
      purchase_date: $.datepicker.formatDate("mm/dd/yy", today)
      effective_date: $.datepicker.formatDate("mm/dd/yy", in_a_week)
    urlRoot: ->
      '/assets'

  class Entities.Assets extends Backbone.Collection
    model: Entities.Asset
    url: ->
      '/assets'
