Collection = require 'models/base/collection'
config = require 'config'  
Dashboard = require 'models/dashboard'
template = require 'views/templates/dashboards/index'
CollectionView = require 'views/base/collection-view'
itemtemplate = require 'views/templates/dashboards/item'
View = require 'views/base/view'
PageView = require 'views/base/page-view'

DashboardItemView= class DashboardView extends View
  template: itemtemplate
  tagName: 'tr'

DashboardListView= class FormsListView extends CollectionView
  tagName: 'tbody'
  itemView: DashboardItemView

module.exports = class DashboardsView extends PageView
  template: template
  autoRender: yes

  renderSubviews: ->
    templates = new Collection null, model: Dashboard
    templates.url = "#{config.api.versionRoot}/dashboards"
    @subview 'templates', new DashboardListView
      collection: templates,
      container: @$('#tpllist')
    templates.fetch()
