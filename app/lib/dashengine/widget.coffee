ModalView = require 'views/base/modal'
WidgetModel = require 'models/widget'
config = require 'config'
clone = (originalArray)->
	$.map originalArray, (obj)->
                      return $.extend(true, {}, obj)

module.exports = class Widget
	template:null
	data:null
	inEditMode:no
	min_size:0
	formsettings:[{type:'text','label':'Widget Size','name':'size'}]

	constructor:(@item,@widgettypes,@datasources,@$el)->
		@settings=@item.settings

		
	render:->
		console.log @
		if not @$el?
			@$el=$("<li/>")
		else
			@$el.empty()

		size = 2
		if @settings?.size?
			size = parseInt(@settings.size)
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
	reload:->
		self=@
		$.get "#{config.api.versionRoot}/widget/#{@item.id}",
				(data) ->
					self.parent.replace self,data
	edit:->
		WidgetsView = require 'views/widgets/edit'
		data= _.extend({"datasources":clone(@datasources),"widgettypes":clone(@widgettypes),"settings":@settings,"datasource_settings":@datasource_settings}, @item)
		view= new WidgetsView({model:new WidgetModel(data)});
		self=@
		view.update=()->
			self.reload()

		new ModalView({ title:"Edit Widget",content: view }).open();
		return
###		@inEditMode=not @inEditMode
		@render()
		if not @inEditMode
			@run()
		$("#engine").trigger("ss-rearrange")###

