Widget  = require 'lib/dashengine/widget'
pietemplate  = require 'lib/dashengine/widgets/templates/pie'
config = require 'config'

module.exports = class Pie extends Widget
	min_size:2

	constructor:(item)->
		super
		@template=pietemplate

	run:->
		dataset = {
		  apples: [53245, 28479, 19697, 24037, 40245],
		  oranges: [200, 200, 200, 200, 200]
			}

		width = (@$el.width()-70)*0.65
		height = width
		radius = Math.min(width, height) / 2;

		color = d3.scale.category20()

		pie = d3.layout.pie()
		    .sort(null).value((d)->d.value);

		arc = d3.svg.arc()
		    .innerRadius((radius)*0.5)
		    .outerRadius(radius ) 

		svg = d3.select(@$el.find('.well')[0]).append("svg")
		    .attr("width", width)
		    .attr("height", height)
		  .append("g")
		    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")

		$.post "#{config.api.versionRoot}/handler/#{@item.dshandler}",
			{settings:@item.datasource_settings},
			(data) ->
				path = svg.selectAll("path")
				    .data(pie(data))
				  .enter().append("path")
				    .attr("fill", (d, i) -> return color(i))
				    .attr("d", arc)
				    .each((d)->this._current = d)
