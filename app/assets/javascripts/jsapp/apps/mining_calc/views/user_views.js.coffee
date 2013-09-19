@BitReturn.module "MiningCalcApp", (MiningCalcApp, App, Backbone, Marionette, $, _) ->

  class MiningCalcApp.UserLoginCornerView extends App.Views.ItemView
    template: "mining_calc/user_login_corner_view"
    modelEvents:
      'change:email': 'render'
    triggers:
      "click #create_account_link": "create_account"

  class MiningCalcApp.EditUserView extends App.Views.ItemView
    template: "mining_calc/templates/edit_user_view"
    form:
      buttons:
        primary: 'Create Account'
        primary_new: 'Create Account'
