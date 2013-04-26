module.exports = (match) ->
  match '', 'home#index'
  match 'datasources', 'datasources#index'
  match 'widgettypes', 'widgettypes#index'
  match 'dashboards', 'dashboards#index'
  match 'dashboards/view/:id', 'dashboards#show'
