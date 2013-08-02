@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.AssetsLayout extends Marionette.Layout
    template: "mining_calc/templates/assets_layout"
    regions:
      minersRegion: "#miners_region"
      benchmarkRegion: "#benchmark_region"

  class MiningCalcApp.AssetView extends Marionette.ItemView
    template: "mining_calc/templates/asset_view"
    tagName: "tr"
    className: "asset"
    triggers:
      "click button.delete": "asset:delete:clicked"
      "click button.edit": "asset:edit:clicked"

#  class List.Empty extends App.Views.ItemView
#    template: "crew/list/_empty"
#    tagName: "li"

  class MiningCalcApp.AssetsListView extends Marionette.CompositeView
    itemViewEventPrefix: "childview"
    template: "mining_calc/templates/assets_list_view"
    itemView: MiningCalcApp.AssetView
#    #emptyView: List.Empty
    itemViewContainer: "tbody"
    triggers:
      "click #add_asset": "add_asset:button:clicked"
