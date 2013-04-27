template = require 'views/templates/widgets/datasource'
layoutedit = require 'views/templates/widgets/layoutedit'
View = require 'views/base/view'
config = require 'config'

module.exports = class DatasourceEditView extends View
  template: template
  autoRender: yes

  initialize: ->
    super
    @Datasources = @model.get('currentds')
    console.log @model

  render:()->
  	super
  	@makeForm(@model.get('datasource_settings'),@$el)
  saveData:()->
    settings = @Datasources.settings
    data = {}
    for field in settings
      if settings.checkbox?
        data[field.name] = if @$el.find("""[name="#{field.name}"]""").is(':checked') then "1" else ""
      else
        data[field.name]=@$el.find("""[name="#{field.name}"]""").val()
    @model.set('datasource_settings',data,{silent: true})
    return

  makeForm: ( data,el) ->
    settings = @Datasources.settings
    el.data("form-settings",settings)
    compliedform=settings.map (setting)->
      setting.value= ""
      setting[setting.type]= 1
      if setting.default?
        setting.value= setting.default
      if data? and data[setting.name]?
        setting.value= data[setting.name]
      if setting.value=="1"
        setting.checked = "checked"
      setting
    console.log compliedform
    el.html(layoutedit({fields: compliedform}))
    el.css({"margin-left": "-30px"})
