Backbone.Marionette.Renderer.render = (template, data) ->
  path = JST["jsapp/apps/" + template]
  throw "Template #{template} not found!" unless path
  res = path(data)
  res
