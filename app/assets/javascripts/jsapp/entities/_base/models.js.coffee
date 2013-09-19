@BitReturn.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Model extends Backbone.Model

    destroy: (options = {}) ->
      _.defaults options,
        wait: true

      @set _destroy: true
      super options

    isDestroyed: ->
      @get "_destroy"

    save: (data, options = {}) ->
      isNew = @isNew()

      _.defaults options,
        wait: true
        success: _.bind(@saveSuccess, @, isNew, options.collection)
        error: _.bind(@saveError, @)

      @unset "_errors"
      super data, options

    saveSuccess: (isNew, collection) =>
      if isNew ## model is being created
        collection.add @ if collection
        collection.trigger "model:created", @ if collection
        #console.log '----- saveSuccess created -----', @
        @trigger "created", @
      else ## model is being updated
        collection ?= @collection ## if model has collection property defined, use that if no collection option exists
        collection.trigger "model:updated", @ if collection
        #console.log '----- saveSuccess updated -----', @
        @trigger "updated", @

    saveError: (model, xhr, options) =>
      @set _errors: $.parseJSON(xhr.responseText) unless xhr.status is 500 or xhr.status is 404
