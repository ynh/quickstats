Model = require 'models/base/model'

module.exports = class Header extends Model
  defaults:
    items: [
      {href: '#/', title: 'Dashboard',search:"^#\/$"}, 
      {href: '#/dashboards', title: 'Dashboards',search:"dashboards"},
      {href: '#/datasources', title: 'DataSources',search:"datasources"},
      {href: '#/widgettypes', title: 'Widget Types',search:"widgettypes"}
    ]
