$j = jQuery.noConflict()

window.getQueryVariable = (variable) ->
  query = window.location.search.substring(1)
  vars = query.split("&")
  i = 0
  while i < vars.length
    pair = vars[i].split("=")
    return decodeURIComponent(pair[1])  if decodeURIComponent(pair[0]) is variable
    i++
  return ''

window.resp2msg = (resp) ->
  if resp.status and resp.responseText and resp.responseText.length < 1024
    "#{resp.responseText} (#{resp.status})"
  else if resp.status and (resp.status == '422' or resp.status == 422)
    "Server communication error. Sorry, we cannot save your data, please try again later."
  else if resp.status
    "Server error: #{resp.status}"
  else
    "Unknown server error"

window.trackevent = (category, action, label, value) ->
  value_str = if value then value else ''
  prefix = switch category
    when 'sync' then '******'
    when 'error' then '!!!!!!'
    else
      '++++++'
  console?.log("#{prefix} #{category} : #{action} : #{label} : #{value_str}")
#_gaq?.push(['_trackEvent', category, action, label, value])

$j.fn.goTo = ->
  $j("html, body").animate
    scrollTop: $(this).offset().top -20 + "px"
  , "fast"
  this

window.input_with_error_poppver_keyup = (e) ->
  el = $(e.target)
  el.unbind('keyup', input_with_error_poppver_keyup)
  el.popover('destroy')

window.show_error_popover = (el_selector, msg, placement, title) ->
  trackevent('error', el_selector, 'msg', if title then title + ': ' + msg else msg)
  if el_selector
    el = $(el_selector)
    el.on('keyup', input_with_error_poppver_keyup) if el.prop('tagName') == 'INPUT'
    placement ||= 'right'
    template = $('#error-popover-template').text()
    template = template.replace(new RegExp("popover-no-title", "gm"), "popover-title") if title
    #el.goTo()
    el.popover('destroy')
    el.popover(content: msg, title: title, placement: placement, template: template)
    el.popover('show')
  else
    template = $('#error-sticky-template').text()
    if title
      template = template.replace(new RegExp("no-title", "gm"), "title")
      template = template.replace(new RegExp("></h3>", "gm"), ">#{title}</h3>")
    template = template.replace(new RegExp("<p></p>", "gm"), "<p>#{msg}</p>")
    $.sticky(template)

window.onerror = (message, url, line) ->
  trackevent('error', 'onerror', "#{url}:#{line}", message)

window.reduceToNode = (item) ->
  item.nodeName ? item: item[0]
