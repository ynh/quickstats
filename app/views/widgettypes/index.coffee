Collection = require 'models/base/collection'
config = require 'config'  
Widgettype = require 'models/widgettype'
template = require 'views/templates/widgettypes/index'
CollectionView = require 'views/base/collection-view'
itemtemplate = require 'views/templates/widgettypes/item'
View = require 'views/base/view'
PageView = require 'views/base/page-view'

WidgettypeItemView= class WidgettypeView extends View
  template: itemtemplate
  tagName: 'tr'

WidgettypeListView= class FormsListView extends CollectionView
  tagName: 'tbody'
  itemView: WidgettypeItemView

module.exports = class WidgettypesView extends PageView
  template: template
  autoRender: yes

  renderSubviews: ->
    templates = new Collection null, model: Widgettype
    templates.url = "#{config.api.versionRoot}/widgettypes"
    @subview 'templates', new WidgettypeListView
      collection: templates,
      container: @$('#tpllist')
    templates.fetch()
