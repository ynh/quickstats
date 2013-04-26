Model = require 'models/base/model'
config = require 'config'
module.exports = class Widgettype extends Model
  idAttribute: "id"
  urlRoot: "#{config.api.versionRoot}/widgettypes"
 