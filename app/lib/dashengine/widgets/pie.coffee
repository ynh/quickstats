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
		fillw = @$el.width()
		width = (@$el.width()-70)*0.65
		height = width
		radius = Math.min(width, height) / 2;

		color = d3.scale.category20()

		pie = d3.layout.pie()
			.sort(null).value((d)->d.value);

		arc = d3.svg.arc()
			.innerRadius((radius)*0.5)
			.outerRadius(radius ) 
		bsvg = d3.select(@$el.find('.well')[0]).append("svg")
		svg = bsvg
			.attr("width", fillw)
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

				legend = bsvg.append("g")
				  .attr("class", "legend")
				  .attr("height", 100)
				  .attr("width", 100)
			 	
				  
				legend.selectAll('rect')
					.data(data)
					.enter()
					.append("rect")
				  .attr("x", fillw*0.62)
					.attr("y", (d, i) -> return i *  20+10)
				  .attr("width", 10)
				  .attr("height", 10)
				  .style("fill", (d,i)->color(i))
					
				legend.selectAll('text')
					.data(data)
					.enter()
					.append("text")
				  .attr("x",  fillw*0.62+20)
					.attr("y", (d, i)-> i *  20 + 9+10)
				  .text (d,i)-> d.key
