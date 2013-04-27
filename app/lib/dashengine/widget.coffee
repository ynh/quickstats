ModalView = require 'views/base/modal'
WidgetModel = require 'models/widget'
module.exports = class Widget
	template:null
	data:null
	inEditMode:no
	min_size:0

	constructor:(@item,@widgettypes,@datasources)->
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
		if not @$el?
			@$el=$("<li/>")
		else
			@$el.empty()

		size = 2
		if @settings?.size?
			size = @settings.size
		minsize= if @inEditMode then Math.max(6,@min_size) else @min_size
		@$el.attr('data-ss-colspan',Math.max(size,minsize))
		#@$el.addClass("widget well span#{size}")
		if @template?
			@$el.append(@template(@item))
		else
			@$el.append("No Template")
		

		if not @inEditMode
			@$el.find(".well").prepend("""<a class="btn btn-success btn-small editbtn" ><i class="icon-pencil"></i> Edit</a>""")
		else
			@$el.find(".well").prepend("""<a class="btn btn-success btn-small editbtn" ><i class="icon-pencil"></i> Save</a>""")
		self=@
		@$el.find(".well").delegate '.editbtn','click', ()->self.edit()
		@$el
	run:->
		false
	edit:->
		WidgetsView = require 'views/widgets/edit'
		data= _.extend({"datasources":@datasources,"widgettypes":@widgettypes,"settings":@settings,"datasource_settings":@datasource_settings}, @item)
		new ModalView({ title:"Edit Widget",content: new WidgetsView({model:new WidgetModel(data)}) }).open();
		return
###		@inEditMode=not @inEditMode
		@render()
		if not @inEditMode
			@run()
		$("#engine").trigger("ss-rearrange")###

