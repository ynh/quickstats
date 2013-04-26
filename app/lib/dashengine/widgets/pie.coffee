Widget  = require 'lib/dashengine/widget'
pietemplate  = require 'lib/dashengine/widgets/templates/pie'

module.exports = class Pie extends Widget

	constructor:(item)->
		super
		@template=pietemplate

	