window.show_flash = (options) ->
  flash = $('#flash')
  msg = options.notice
  flash_class = 'alert-success'
  if options.error
    msg = options.error
    flash_class = 'alert-error'
  button = $('<button type="button" class="close" data-dismiss="alert">×</button>')
  button.on 'click', -> flash.slideUp()
  alert_div = $('<div>').addClass('alert').addClass(flash_class)
  alert_div.append(button)
  alert_div.append(msg)
  flash.html(alert_div).slideDown()
  setTimeout((-> flash.slideUp()), 5000)
