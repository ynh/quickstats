Widget  = require 'lib/dashengine/widget'
template  = require 'lib/dashengine/widgets/templates/trend'
edittemplate  = require 'lib/dashengine/widgets/templates/edit'

module.exports = class Trend extends Widget
    min_size:2
	

    constructor:(item)->
        super
        @template=template

    run:->