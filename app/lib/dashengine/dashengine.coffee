module.exports = class Dashengine
	$el:null
	widgets= []
	constructor:(element,data,@widgettypes,@datasources)->
		@$el=element
		@data=data
		@widgets=[]
		for item in data
			widget = require "lib/dashengine/widgets/#{item.wthandler}"
			@widgets.push(new widget(item,@widgettypes,@datasources))
		return

	render:()->
		for widget in @widgets
			@$el.append( widget.render())

	run:()->
		for widget in @widgets
			widget.run()
		return


	