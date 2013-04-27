template = require 'views/templates/widgets/datasource'
layoutedit = require 'views/templates/widgets/layoutedit'
View = require 'views/base/view'
config = require 'config'

module.exports = class WidgetSettingsView extends View
  template: template
  autoRender: yes

  initialize: ->
    super
    @Widgettypes = @model.get('currentws')
    console.log @model

  render:()->
  	super
  	@makeForm(@model.get('settings'),@$el)
  saveData:()->
    settings = @Widgettypes.settings
    data = {}
    for field in settings
      if field.checkbox?
        data[field.name] = if @$el.find("""[name="#{field.name}"]""").is(':checked') then "1" else ""
      else
        data[field.name]=@$el.find("""[name="#{field.name}"]""").val()
    @model.set('settings',data,{silent: true})
    return

  makeForm: ( data,el) ->
    settings = @Widgettypes.settings
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
      else
        setting.checked = ""

      setting
    console.log compliedform
    el.html(layoutedit({fields: compliedform}))
    el.css({"margin-left": "-30px"})
