module.exports = class Widget
	template:null
	edittemplate:null
	data:null
	inEditMode:no

	constructor:(@item)->
		try
			@settings=jQuery.parseJSON(item.settings)
		catch e
			@settings={}
			console.log e

		try
			@datasource_settings=jQuery.parseJSON(item.datasource_settings)
		catch e
			@datasource_settings={}
			console.log e
		
		


	render:->
		console.log @
		@$el=$("<li/>")
		size = 2
		if @settings?.size?
			size = @settings.size
		@$el.attr('data-ss-colspan',size)
		#@$el.addClass("widget well span#{size}")
		if not @inEditMode
			if @template?
				@$el.append(@template(@item))
			else
				@$el.append("No Template")
		else
			if @edittemplate?
				@$el.append(@edittemplate(@item))
			else
				@$el.append("No Edit Template")
		@$el

	run:->
		false