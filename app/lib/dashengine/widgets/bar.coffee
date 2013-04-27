Widget  = require 'lib/dashengine/widget'
pietemplate  = require 'lib/dashengine/widgets/templates/pie'
config = require 'config'
module.exports = class Bar extends Widget
    min_size:4
    formsettings:[{type:'text','label':'Widget Size','name':'size'},{type:'text','label':'Height %','name':'height'},{type:'checkbox','label':'Logarithm ','name':'logarithm'},{type:'checkbox','label':'Line Chart','name':'line'}]

    constructor:(item)->
        super
        @template=pietemplate 


    run:-> 
        heightr = 0.55
        if @settings?.height? and @settings.height != ""
            heightr = parseFloat(@settings.height)
        margin = {top: 20, right: 10, bottom: 60, left: 70}
        width = (@$el.width()-30)- margin.left - margin.right
        height = (@$el.width()-30)*heightr - margin.top - margin.bottom
        formatter = d3.format("4d");

        x = d3.scale.ordinal()
            .rangeRoundBands([0, width], .1);

        y = d3.scale.linear()
        islog = false
        if @settings?.logarithm? and @settings.logarithm == "1"
          islog= true
          y = d3.scale.log()
        

        color = d3.scale.category20()
        xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom").ticks(width/30);

        yAxis = d3.svg.axis()
            .scale(y)
            .orient("left")

        if islog
          yAxis.ticks(height/30,formatter)
        else
          yAxis.ticks(height/30)

        svg = d3.select(@$el.find('.well')[0]).append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
          .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
        isline= @settings?.line? and @settings.line == "1"
        self=@

        $.post "#{config.api.versionRoot}/handler/#{@item.dshandler}",
          {settings:@item.datasource_settings},
          (data) ->
            x.domain(data.map((d)->d.key));
            y.domain([0.1, d3.max(data, (d)-> return parseInt(d.value))]).range([height, 0]);

            axis = svg.append("g")
                  .attr("class", "x axis")
                  .attr("transform", "translate(0," + height + ")")
                  .call(xAxis);
            if isline
              line = d3.svg.line()
                  .x((d)->return x(d.key))
                  .y((d)->return y(d.value))
              svg.append("path")
                .datum(data)
                .attr("class", "line")
                .attr("d", line)
              svg.selectAll(".circle")
                    .data(data)
                  .enter().append("circle") 
                    .attr("cx", (d)-> return x(d.key))
                    .attr("r", ()->4)
                    .attr("cy", (d)->return y(d.value))
            else
              svg.selectAll(".bar")
                    .data(data)
                  .enter().append("rect")
                    .style("fill", (d,i)->color(i))
                    .attr("class", "bar")
                    .attr("x", (d)-> return x(d.key))
                    .attr("width", x.rangeBand())
                    .attr("y", (d)->return y(d.value))
                    .attr("height",  (d)->  height - y(d.value) )

            svg.append("g")
                  .attr("class", "y axis")
                  .call(yAxis)

            axis.selectAll("text")  
            .style("text-anchor", "end")
            .attr("dx", "-.8em")
            .attr("dy", ".15em")
            .attr "transform",(d)-> "rotate(-65)translate(-6,-3)" 
         
