Controller = require 'controllers/base/controller'
DatasourcesView = require 'views/datasources'

Datasource = require 'models/datasource'

module.exports = class DatasourcesController extends Controller
  index: ->
    @view = new DatasourcesView region: 'main' 