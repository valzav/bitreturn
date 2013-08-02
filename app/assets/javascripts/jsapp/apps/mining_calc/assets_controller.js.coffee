@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  MiningCalcApp.AssetsController =

    show: ->
      assets = new App.Entities.Assets(gon.assets)
      @layout = new MiningCalcApp.AssetsLayout
      @layout.on 'show', =>
        console.log 'AssetsLayout on show'
        @showMinersRegion assets
      App.assetsRegion.show @layout


    showMinersRegion: (assets) ->
      view = new MiningCalcApp.AssetsListView collection: assets
      view.on "add_asset:button:clicked", =>
        assets.add(new App.Entities.Asset)
      view.on "childview:asset:delete:clicked", (child, args) ->
        model = args.model
        #model.destroy()
        assets.remove(model)
      view.on "childview:asset:edit:clicked", (child, args) ->
        App.vent.trigger "asset:edit:clicked", args.model
      @layout.minersRegion.show view
