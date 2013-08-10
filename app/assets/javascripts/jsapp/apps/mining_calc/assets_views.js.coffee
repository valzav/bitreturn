@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.AssetsLayout extends App.Views.Layout
    template: "mining_calc/assets_layout"
    regions:
      minersRegion: "#miners_region"
      benchmarkRegion: "#benchmark_region"

  class MiningCalcApp.AssetView extends App.Views.ItemView
    template: "mining_calc/asset_view"
    tagName: "tr"
    className: "asset"
    triggers:
      "click a.delete": "asset:delete:clicked"
      "click a.edit": "asset:edit:clicked"

#  class List.Empty extends App.Views.ItemView
#    template: "crew/list/_empty"
#    tagName: "li"

  class MiningCalcApp.AssetsListView extends App.Views.CompositeView
    template: "mining_calc/assets_list_view"
    itemView: MiningCalcApp.AssetView
#    #emptyView: List.Empty
    itemViewContainer: "tbody"
    triggers:
      "click #add_asset": "add_asset:button:clicked"
