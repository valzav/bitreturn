do (Backbone, Marionette) ->
	
	class Marionette.Region.Dialog extends Marionette.Region
		
		onShow: (view) ->
      @$el.modal()
      @$el.on 'hidden', => @close()
