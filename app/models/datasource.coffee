Model = require 'models/base/model'
config = require 'config'
module.exports = class Datasource extends Model
  idAttribute: "id"
  urlRoot: "#{config.api.versionRoot}/datasources"
 