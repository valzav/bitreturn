do (Backbone, Marionette) ->
	
	class Marionette.Region.Dialog extends Marionette.Region
		
		onShow: (view) ->
      #console.log view
      view.on "form:cancel dialog:close", => @$el.modal('hide')
      @$el.modal()
      @$el.on 'hidden', => @close()
