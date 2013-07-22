
window.save_model = (model, button, on_success = null) ->
  window.model_is_saving = true
  options =
    success: (model) ->
      window.model_is_saving = false
      on_success(model) if on_success
    error: (model, response) ->
      window.model_is_saving = false
      msg = resp2msg(response)
      trackevent('save_model', model.url(), msg, '')
      show_flash(error: "Data cannot be saved - #{msg}")
      hide_loader(button) if button
  model.save null, options
