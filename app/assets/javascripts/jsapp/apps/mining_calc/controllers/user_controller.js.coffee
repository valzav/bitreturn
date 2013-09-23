@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->
  MiningCalcApp.UserController =

    showCreateAccountDialog: ->
      user = App.request "current:user"
      editView = new MiningCalcApp.EditUserView model: user
      formView = App.request "form:wrapper", editView
      App.dialogRegion.show formView

    showUserLoginCorner: ->
      user = App.request "current:user" unless user
      view = new MiningCalcApp.UserLoginCornerView model: user
      view.on 'create_account', =>
        @showCreateAccountDialog()
      App.userLoginCornerRegion.show view
