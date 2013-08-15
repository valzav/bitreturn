@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  MiningCalcApp.AssetsController =

    show: ->
      assets = App.request "assets:entities"
      @layout = new MiningCalcApp.AssetsLayout
      @layout.on 'show', =>
        @showMinersRegion assets
      App.assetsRegion.show @layout


    showMinersRegion: (assets) ->
      view = new MiningCalcApp.AssetsListView collection: assets
      view.on "add_asset:button:clicked", =>
        #assets.add(new App.Entities.Asset)
        App.vent.trigger "asset:edit:clicked"

      view.on "childview:asset:delete:clicked", (child, args) ->
        model = args.model
        model.destroy() if confirm "Are you sure you want to delete #{model.get("name")}?"
      view.on "childview:asset:edit:clicked", (child, args) ->
        App.vent.trigger "asset:edit:clicked", args.model
      @layout.minersRegion.show view
