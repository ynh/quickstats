Widget  = require 'lib/dashengine/widget'
pietemplate  = require 'lib/dashengine/widgets/templates/pie'
config = require 'config'
module.exports = class Bar extends Widget
    min_size:6

    constructor:(item)->
        super
        @template=pietemplate

    run:-> 
        margin = {top: 20, right: 20, bottom: 30, left: 40}
        width = (@$el.width()-70)- margin.left - margin.right
        height = (@$el.width()-70)*0.55 - margin.top - margin.bottom

        formatPercent = d3.format(".0%");

        x = d3.scale.ordinal()
            .rangeRoundBands([0, width], .1);

        y = d3.scale.linear()
            .range([height, 0]);

        xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

        yAxis = d3.svg.axis()
            .scale(y)
            .orient("left")
            .tickFormat(formatPercent);

        svg = d3.select(@$el.find('.well')[0]).append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
          .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        $.post "#{config.api.versionRoot}/handler/#{@item.dshandler}",
          {settings:@item.datasource_settings},
          (data) ->
            data.forEach (d)->
                d.value = +d.value;
                return
            x.domain(data.map((d)->d.key));
            y.domain([0, d3.max(data, (d)-> return d.value)]);

            svg.append("g")
                  .attr("class", "x axis")
                  .attr("transform", "translate(0," + height + ")")
                  .call(xAxis);

            svg.append("g")
                  .attr("class", "y axis")
                  .call(yAxis)
                .append("text")
                  .attr("transform", "rotate(-90)")
                  .attr("y", 6)
                  .attr("dy", ".71em")
                  .style("text-anchor", "end")
                  .text("Frequency");

            svg.selectAll(".bar")
                  .data(data)
                .enter().append("rect")
                  .attr("class", "bar")
                  .attr("x", (d)-> return x(d.key))
                  .attr("width", x.rangeBand())
                  .attr("y", (d)->return y(d.value))
                  .attr("height",  (d)->  height - y(d.value) )
