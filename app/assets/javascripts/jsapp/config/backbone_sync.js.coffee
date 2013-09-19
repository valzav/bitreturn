getValue = (object, prop) ->
  return null  unless object and object[prop]
  (if _.isFunction(object[prop]) then object[prop]() else object[prop])

#Backbone._sync = Backbone.sync
#Backbone.sync = (method, model, options) ->
#  ts = new Date().getTime()
#  url = options.url || getValue(model, 'url')
#  prt = document.location.protocol
#  prt = 'http:' if prt == 'file:'
#  if options.skip_access_token
#    options.url = "#{prt}//#{window.DataHost}/api/v1#{url}?ts=#{ts}"
#  else
#    user = Etsonic.user
#    options.url = "#{prt}//#{window.DataHost}/api/v1#{url}?user_credentials=#{user.get('single_access_token')}&ts=#{ts}"
#  model_str = if method == 'read' then '-' else JSON.stringify(model)
#  trackevent('sync', method, options.url, model_str)
#  Backbone._sync(method, model, options)

Backbone._sync = Backbone.sync
Backbone.sync = (method, model, options) ->
  url = options.url || getValue(model, 'url')
  #if options.skip_access_token or !window.user
  options.url = "/api/v1#{url}"
  #else
  #  options.url = "/api/v1#{url}?user_credentials=#{window.user.get('single_access_token')}"
  model_str = if method == 'read' then '-' else JSON.stringify(model)
  trackevent('sync', method, options.url, model_str)
  Backbone._sync(method, model, options)
