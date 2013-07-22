window.spinner_opts =
{ lines: 13, length: 7, width: 2, radius: 4, corners: 1, rotate: 0, color: "#eee", speed: 1, trail: 41, shadow: false, hwaccel: true, className: "spinner", zIndex: 2e9, top: "auto", left: "auto"}

window.show_loader = ($el, text) ->
  spinner = new Spinner(spinner_opts).spin()
  old_text = $el.text()
  $el.data('text', old_text)
  $el.addClass('disabled').addClass('btn-loader')
  $el.html(spinner.el).append(text || old_text).parent().addClass('disabled')

window.hide_loader = ($el) ->
  return unless $el.hasClass('disabled')
  $el.removeClass('disabled')
  $el.html($el.data('text')).parent().removeClass('disabled').removeClass('btn-loader')
