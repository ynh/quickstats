Controller = require 'controllers/base/controller'
WidgettypesView = require 'views/widgettypes'

Widgettype = require 'models/widgettype'

module.exports = class WidgettypesController extends Controller
  index: ->
    @view = new WidgettypesView region: 'main' 