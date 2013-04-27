module.exports = class Dashengine
	$el:null
	widgets:[]
	constructor:(element,data,@widgettypes,@datasources)->
		@$el=element
		@data=data
		@widgets=[] 
		for item in data
			widget = require "lib/dashengine/widgets/#{item.wthandler}"
			w = new widget(item,@widgettypes,@datasources)
			w.parent = @
			@widgets.push(w)
		return

	render:()->
		for widget in @widgets
			@$el.append( widget.render())

	run:()->
		for widget in @widgets
			widget.run()
		return

	replace:(old,newdata)->
		widget = require "lib/dashengine/widgets/#{newdata.wthandler}" 
		old.$el.empty()
		w = new widget(newdata,@widgettypes,@datasources,old.$el)
		w.parent = @
		@widgets.push(w)
		w.render()
		w.run()
		$("#engine").trigger("ss-rearrange")


	