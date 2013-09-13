@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.AnalysisResult extends Entities.Model
    urlRoot: ->
      '/analysis_results'
    get_ar: (asset_id) ->
      ars = @get('ars')
      for r in ars
        return new Entities.AnalysisResult(r) if r.asset_id == asset_id
      return null
