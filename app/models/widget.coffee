Model = require 'models/base/model'
config = require 'config'
module.exports = class Widget extends Model
  idAttribute: "id"
  urlRoot: "#{config.api.versionRoot}/widget"
  unsets: ['currentds','datasources','widgettypes','currentws']
 