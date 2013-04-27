template = require 'views/templates/widgets/edit'
DatasourceEdit = require 'views/widgets/datasource'
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

  editDs:->

    currentdsid = $("#Datasource").val();
    currentds = {}
    for ds in @Datasources
      if ds.id==currentdsid
        currentds = ds

    console.log currentds
    @model.set('currentds',currentds)
    new ModalView({ title:"Connect via #{currentds.name}",content: new DatasourceEdit({model:@model}) }).open();
    return