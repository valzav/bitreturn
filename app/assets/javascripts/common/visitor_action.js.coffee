$j = jQuery.noConflict()

getValue = (object, prop) ->
  return null  unless object and object[prop]
  (if _.isFunction(object[prop]) then object[prop]() else object[prop])

Backbone._sync = Backbone.sync
Backbone.sync = (method, model, options) ->
  url = options.url || getValue(model, 'url')
  if options.skip_access_token
    options.url = "/api/v1#{url}"
  else
    options.url = "/api/v1#{url}?user_credentials=#{window.user.get('single_access_token')}"
  model_str = if method == 'read' then '-' else JSON.stringify(model)
  trackevent('sync', method, options.url, model_str)
  Backbone._sync(method, model, options)

window.App = {}

App.VisitorAction = Backbone.Model.extend
  defaults:
    visid: ''
    sesid: ''
    category: ''
    action: ''
    value: ''
  url: ->
    "/visitor_actions"
  toJSON: ->
    visitor_action: _.clone(@attributes)

createUUID = ->
  s = [];
  hexDigits = "0123456789abcdef";
  i = 0
  while i < 12
    s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1)
    i++
  s.join("")

App.track_action = (category, action, value) ->
  visid = $j.cookie('visid')
  sesid = $j.cookie('sesid')
  unless visid
    visid = createUUID()
    jQuery.cookie('visid', visid, { expires: 365, path: '/' })
    sesid = createUUID()
    jQuery.cookie('sesid', sesid, { path: '/' })
  va = new App.VisitorAction(category: category, action: action, value: value)
  trackevent(category, action, '', value)
  va.save(visid: visid, sesid: sesid, {skip_access_token: true})
