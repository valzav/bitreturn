window.resp2msg = (resp) ->
  if resp.status and resp.responseText and resp.responseText.length < 512
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
    else '++++++'
  console?.log("#{prefix} #{category} : #{action} : #{label} : #{value_str}")
  #_gaq?.push(['_trackEvent', category, action, label, value])
