Collection = require 'models/base/collection'
config = require 'config'  
Datasource = require 'models/datasource'
template = require 'views/templates/datasources/index'
CollectionView = require 'views/base/collection-view'
itemtemplate = require 'views/templates/datasources/item'
View = require 'views/base/view'
PageView = require 'views/base/page-view'

DatasourceItemView= class DatasourceView extends View
  template: itemtemplate
  tagName: 'tr'

DatasourceListView= class FormsListView extends CollectionView
  tagName: 'tbody'
  itemView: DatasourceItemView

module.exports = class DatasourcesView extends PageView
  template: template
  autoRender: yes

  renderSubviews: ->
    templates = new Collection null, model: Datasource
    templates.url = "#{config.api.versionRoot}/datasources"
    @subview 'templates', new DatasourceListView
      collection: templates,
      container: @$('#tpllist')
    templates.fetch()
