Controller = require 'controllers/base/controller'
DashboardsList = require 'views/dashboards'
DashboardView = require 'views/dashboards/view'
Dashboard = require 'models/dashboard'

module.exports = class DashboardsController extends Controller
  index: ->
    @view = new DashboardsList region: 'main' 

  show: (params)->
    dashboard = new  Dashboard({id:params.id})
    @view = new DashboardView({model:dashboard})
    dashboard.fetch(); 
