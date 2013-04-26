module.exports = class Dashengine
	$el:null
	widgets= []
	constructor:(element,data)->
		@$el=element
		@data=data
		@widgets=[]
		for item in data
			widget = require "lib/dashengine/widgets/#{item.wthandler}"
			@widgets.push(new widget(item))
		return

	render:()->
		for widget in @widgets
			@$el.append( widget.render())


	