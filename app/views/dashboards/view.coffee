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
    container = @$el.find("#engine")
    @de=new Dashengine(container,@model.get('_widgets'))
    @de.render() 
  attach:->
    super
    @de.run() 
    @$el.find("#engine").shapeshift({
        gutterX: 8,
        gutterY: 5,
        minColumns: 12,
        colWidth:90,
        paddingX: 0,
        paddingY: 0
    })