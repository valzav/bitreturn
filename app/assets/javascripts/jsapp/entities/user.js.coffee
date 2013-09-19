@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.User extends Entities.Model
    urlRoot: ->
      '/users'
    hasAccount: ->
      not _.isEmpty(@get('email'))

  App.reqres.setHandler "set:current:user", (user_attrs)->
    window.user = new Entities.User(user_attrs)

  App.reqres.setHandler "current:user", ->
    window.user
