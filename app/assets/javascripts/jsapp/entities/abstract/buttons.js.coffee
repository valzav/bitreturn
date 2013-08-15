@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Button extends Entities.Model
    defaults:
      buttonType: "button"

  class Entities.ButtonsCollection extends Entities.Collection
    model: Entities.Button

  API =
    getFormButtons: (buttons, model) ->
      buttons = @getDefaultButtons buttons, model

      button_text = if model.isNew() then buttons.primary_new else buttons.primary
      array = []
      array.push { type: "cancel", className: "btn", text: buttons.cancel} unless buttons.cancel is false
      array.push { type: "primary", className: "btn btn-primary", text: button_text, buttonType: "submit" } unless buttons.primary is false

      array.reverse() if buttons.placement is "left"

      buttonCollection = new Entities.ButtonsCollection array
      buttonCollection.placement = buttons.placement
      buttonCollection

    getDefaultButtons: (buttons, model) ->
      _.defaults buttons,
        primary: 'Update'
        primary_new: 'Create'
        cancel: "Cancel"
        placement: "right"

  App.reqres.setHandler "form:button:entities", (buttons = {}, model) ->
    API.getFormButtons buttons, model
