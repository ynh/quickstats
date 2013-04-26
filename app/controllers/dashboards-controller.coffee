Controller = require 'controllers/base/controller'
DashboardsView = require 'views/dashboards'


module.exports = class DashboardsController extends Controller
  index: ->
    @view = new DashboardsView region: 'main' 
