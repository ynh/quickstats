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
    @de=new Dashengine(container,@model.get('_widgets'),@model.get('_widgettypes'),@model.get('_datasources'))
    @de.render() 
  attach:->
    super
    @de.run() 
    @$el.find("#engine").shapeshift({
           gutterX: 8,
        gutterY: 5,
        columns: 12,
        colWidth:90, 
        paddingY: 0
    })
    container = @$el.find("#engine").children()
    con=@$el.find("#engine");
    @$el.on "ss-rearranged", (e, selected) ->
        data= ({id:$(item).data("controller").item.id,order:$(item).index()} for item in container)
        $.post "#{config.api.versionRoot}/order",
              {order:data},
              (data) ->
                return