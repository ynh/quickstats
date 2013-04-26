Model = require 'models/base/model'
config = require 'config'
module.exports = class Dashboard extends Model
  idAttribute: "id"
  urlRoot: "#{config.api.versionRoot}/dashboards"
 