View = require 'views/base/view'
template = require 'views/templates/header'

Header = require 'models/header'

module.exports = class HeaderView extends View
  autoRender: yes
  className: 'header'
  region: 'header'
  id: 'header'
  template: template

  initialize: ->
    super
    @model=new Header() 

  afterRender: ->
    super
    @updateMenu()
    return

  updateMenu:->
    path= $(location).attr('hash')
    @$el.find(".active").removeClass("active")
    for menu in @$el.find('.nav').children()
      link=$(menu).find('a')
      if link.length>0 and link.attr('data-search')?
        if new RegExp(link.attr('data-search')).test(path)
          @$el.find(".active").removeClass("active")
          $(menu).addClass("active")

