template = require 'views/templates/dashboards/view'
PageView = require 'views/base/page-view'
config = require 'config' 

module.exports = class DashboardView extends PageView
  template: template
  autoRender: no

  initialize: ->
    super

  render:->
    super
    Dashengine  = require 'lib/dashengine/dashengine'
    @de=new Dashengine(@$el.find("#engine"),@model.get('_widgets'))
    @de.render()