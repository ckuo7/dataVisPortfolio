





//Get the query string from the page URL, decode (Links to an external site.) the text, and convert it to lower case.
console.log(window.location.search.substr(1).toLowerCase().match(/[a-zA-Z]/g));

//Loop through the text and store the count for all letters ([A-z]) in a JavaScript object (Links to an external site.)
// (similar to a dictionary in Python). Use the letter as the key and the count as the value. Do not store spaces,
// punctuation, or special characters.
var query = window.location.search.substr(1).toLowerCase().match(/[a-zA-Z]/g);
var words = {};

for ( var i =0 ; i < query.length; i++)
{
	if (query[i] in words){
	words[query[i]]++;}
	else{
	words[query[i]] = 1;
	}
}
var wordsKeySort = Object.keys(words).sort();
var wordsValue = Object.keys(words).map(function(k){ return words[k]});

//Log the decoded input text and counts to the console.
console.log(words);


var margin = {top: 20, right: 20, bottom: 40, left: 80},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;


var yScale = d3.scale.linear().domain([0, d3.max(wordsValue)]).range([0, height]);
var xScale = d3.scale.ordinal().domain( d3.range(0,wordsKeySort.length)).rangeBands([0,width],0.1);

var xScaleAxis = d3.scale.ordinal().domain( wordsKeySort).rangeBands([0,width],0.1);
var yScaleAxis = d3.scale.linear().domain([0, d3.max(wordsValue)]).range([height,0]);

//Modify the tick label formatting (e.g. change number of decimal points visible, size, spacing and/or frequency).
var format = d3.format("4d");
var xAxis = d3.svg.axis()
	.scale(xScaleAxis)
    .orient("bottom")
	.tickSize(0);
	//.tickValues(wordsKeySort);
var yAxis = d3.svg.axis()
    .scale(yScaleAxis)
    .orient("left").tickFormat( function(d){ return format(d);}) ;

//var tip = d3.tip()
//  .attr('class', 'd3-tip')
//  .offset([-10, 0]).style({"line-height":1,"color":"#fff","border-radius":"2px"});
  //.html(function(d) {
  //  return "<strong>Frequency:</strong> <span style='color:red'>" + d.frequency + "</span>";
  //});

//Display a basic non-interactive bar chart of the counts using D3 in an SVG. You can use the final code (source
// (Links to an external site.)) from the bar chart tutorial (link (Links to an external site.)) as a starting point.
d3.select('#chart').append("svg").style({'background':'#FFFFFF'})
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
	.append('g')
	.selectAll('rect').data(wordsKeySort).enter().append('rect')
	.attr('width', xScale.rangeBand())
	.attr('height', function(d){
		d3.select(this).transition().duration(300);
		return yScale(words[d]);})
	.style('fill','#2171B5')
	.attr('x', function(d,i){ return  margin.left  + xScale(i);})
	.attr('y', function(d){ return ( height + margin.top - yScale(words[d]));})
	.on('mouseover', function(d){
		d3.select(this).style('fill',"#FD8D3C");
		//tip.show()
		//Get this bar's x/y values, then augment for the tooltip
		var xPosition = parseFloat(d3.select(this).attr("x")) + xScale.rangeBand() / 2;
		var yPosition = parseFloat(d3.select(this).attr("y")) + 18;
		d3.select('svg').append("text")
  		.attr("id", "tooltip")
  		.attr("x", xPosition)
  .attr("y", yPosition)
  .attr("text-anchor", "middle")
  .attr("font-family", "sans-serif")
  .attr("font-size", "18px")
  .attr("font-weight", "bold")
  .attr("fill", "white")
  .text(words[d]);


	})
	.on('mouseout', function(d){
		d3.select(this).style('fill',"#2171B5")

		d3.select("#tooltip").remove();
	})
	;

//d3.select("rect").transition().delay(3);

var x = d3.select('svg').append('g')
		.call(xAxis)
		.attr('transform',"translate(" + margin.left.toString() + "," + (height+margin.top+5).toString() + ")");

x.selectAll('path').style({"fill":"none","stroke":"none"});
x.selectAll('line').style({"stroke":"black"});
var y = d3.select('svg').append('g')
		.call(yAxis)
		.attr('transform',"translate(" + margin.left.toString() + "," + margin.top.toString() +")");
d3.select('g').append("text")
	.attr("transform","rotate(-90)")
	.attr("y",margin.left+20).attr("x",-20).style("text-anchor","end").text("Count");

y.selectAll('path').style({"fill":"none","stroke":"black"});
y.selectAll('line').style({"stroke":"black","fill":"black"});


var tip = d3.tip()
  .attr('class', 'd3-tip')
  .offset([-10, 0])
  .html(function(d) {
    return "<strong>Frequency:</strong> <span style='color:red'>" + d.frequency + "</span>";
  });

//.attr("transform","rotate(-90)")
    //.attr("transform", "translate(" + margin.left + "," + margin.top + ")")

//d3.tsv("data.tsv", type, function(error, data) {
//  x.domain(data.map(function(d) { return d.letter; }));
//  y.domain([0, d3.max(data, function(d) { return d.frequency; })]);
//
//  svg.append("g")
//      .attr("class", "x axis")
//      .attr("transform", "translate(0," + height + ")")
//      .call(xAxis);
//
//  svg.append("g")
//      .attr("class", "y axis")
//      .call(yAxis)
//    .append("text")
//      .attr("transform", "rotate(-90)")
//      .attr("y", 6)
//      .attr("dy", ".71em")
//      .style("text-anchor", "end")
//      .text("Frequency");
//
//  svg.selectAll(".bar")
//      .data(data)
//    .enter().append("rect")
//      .attr("class", "bar")
//      .attr("x", function(d) { return x(d.letter); })
//      .attr("width", x.rangeBand())
//      .attr("y", function(d) { return y(d.frequency); })
//      .attr("height", function(d) { return height - y(d.frequency); });
//
//});
//
//function type(d) {
//  d.frequency = +d.frequency;
//  return d;
//}

//['backgroud','padding','margin','color'],
	//.insert('div',':first-child')
	//.html('<strong>Daniel Kuo</strong>')// find the item within the id = chart
