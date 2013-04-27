template = require 'views/templates/widgets/edit'
DatasourceEdit = require 'views/widgets/datasource'
WidgetSettings = require 'views/widgets/widgetsettings'
View = require 'views/base/view'
config = require 'config'
ModalView = require 'views/base/modal'
module.exports = class WidgetsView extends View
  template: template
  autoRender: yes

  initialize: ->
    super
    @Datasources = @model.get('datasources')
    @Widgettypes = @model.get('widgettypes')
    datasource_id = @model.get('datasource_id')
    widgettype_id = @model.get('widgettype_id')
    @delegate 'change', '.field', @field_changed
    Item = @model.get('item')
    for ds in @Datasources
      if ds.id==datasource_id
        ds.selected= "selected"
    for ds in @Widgettypes
      if ds.id==widgettype_id
        ds.selected= "selected"
    self=@
    @delegate 'click', '.dsedit', (event)->
      event.preventDefault()
      self.editDs()
    @delegate 'click', '.wsedit', (event)->
      event.preventDefault()
      self.editWs()

  saveData:()->
    @model.save()
    @update()
    return

  field_changed:(e)->
    if $(e.target).is(':checkbox')
      @model.set($(e.target).attr('data-name'),$(e.target).is(':checked'),{silent:1})
    else
      @model.set($(e.target).attr('data-name'),$(e.target).val(),{silent:1})
    return

  editDs:->

    currentdsid = $("#Datasource").val();
    currentds = {}
    for ds in @Datasources
      if ds.id==currentdsid
        currentds = ds
    @model.set('currentds',currentds)
    new ModalView({ title:"Connect via #{currentds.name}",content: new DatasourceEdit({model:@model}) }).open();
    return

  editWs:->

    currentdsid = $("#WidgetType").val();
    currentws = {}
    for ws in @Widgettypes
      if ws.id==currentdsid
        currentws = ws
    #UGLY HACK
    widget = require "lib/dashengine/widgets/#{currentws.handler}"
    w = new widget({},@widgettypes,@datasources)
    currentws.settings= w.formsettings
    @model.set('currentws',currentws)
    new ModalView({ title:"#{currentws.name} Settings",content: new WidgetSettings({model:@model}) }).open();
    return