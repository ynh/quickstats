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
		el = null
		if old?
			el = old.$el
			old.$el.empty()
			w = new widget(newdata,@widgettypes,@datasources,el)
		else
			w = new widget(newdata,@widgettypes,@datasources	)
		
		w.parent = @
		@widgets.push(w)
		
		if not old?
			newel = w.render()
			@$el.append(newel)
			alert("added")
			w.run()
			newel.trigger("ss-added")
		else
			w.render()
			w.run()
		
		$("#engine").trigger("ss-rearrange")


	