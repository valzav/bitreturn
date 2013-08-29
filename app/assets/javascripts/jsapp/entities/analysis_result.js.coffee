@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.AnalysisResult extends Entities.Model
    urlRoot: ->
      '/analysis_results'
