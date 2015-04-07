





//Get the query string from the page URL, decode (Links to an external site.) the text, and convert it to lower case.
console.log(window.location.search.substr(1).toLowerCase().match(/[a-zA-Z]/g));

//Loop through the text and store the count for all letters ([A-z]) in a JavaScript object (Links to an external site.)
// (similar to a dictionary in Python). Use the letter as the key and the count as the value. Do not store spaces,
// punctuation, or special characters.
var query = window.location.search.substr(1).toLowerCase().match(/[a-zA-Z]/g);
var words = {};
var wordList = [];

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

for ( var j =0 ; j < wordsKeySort.length; j++){

	temp = {};
	temp['letter'] = wordsKeySort[j];
	temp['frequency'] = words[wordsKeySort[j]];
	wordList.push(temp);
}
console.log(wordList);

//Log the decoded input text and counts to the console.
console.log(words);


var margin = {top: 30, right: 20, bottom: 40, left: 80},
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
//  .html(function(d) {
//    return "<strong>Frequency:</strong> <span style='color:red'>" + d.frequency + "</span>";
//  });

//Display a basic non-interactive bar chart of the counts using D3 in an SVG. You can use the final code (source
// (Links to an external site.)) from the bar chart tutorial (link (Links to an external site.)) as a starting point.
function vowelTest(s) {
  return (/^[aeiou]$/i).test(s);
}
var svg = d3.select('#chart').append("svg").style({'background':'#FFFFFF'})
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
	.append('g')
	.selectAll('rect').data(wordsKeySort).enter().append('rect')
	.attr('width', xScale.rangeBand())
	//.attr('height', function(d){
	//
	//	return yScale(words[d]);})
	.attr('height', 0)
	.style('fill',function(d){

			if (vowelTest(d)){

				return "#2171B5";
			}
			else{
				return "#92C5DE";
			}
		})
	.attr('x', function(d,i){ return  margin.left  + xScale(i);})
	//.attr('y', function(d){ return ( height + margin.top - yScale(words[d]));})
	.attr('y', height+margin.top)
	.on('mouseover', function(d){
		d3.select(this).style('fill',"#FD8D3C");
		var xPosition = parseFloat(d3.select(this).attr("x")) + xScale.rangeBand() / 2;
		var yPosition = parseFloat(d3.select(this).attr("y")) - 12;

		d3.select('svg').append("text")
			.attr("id", "tooltip")
			.attr("x", xPosition)
			.attr("y", yPosition)
			.attr("text-anchor", "middle")
			.attr("font-family", "sans-serif")
			.attr("font-size", "18px")
			.attr("font-weight", "bold")
			.attr("fill", "black")
			.text(words[d]);
	})
	.on('mouseout', function(d){
		d3.select(this).style('fill',function(d){

			if (vowelTest(d)){return "#2171B5";}
			else{return "#92C5DE";}
			});
		d3.select("#tooltip").remove();
	});

d3.selectAll('rect').data(wordsKeySort)
	.transition().duration(500).delay(function(d,i){return 100*i;})
	.attr("height",function(d){return( yScale(words[d]));})
	.attr("y",function(d){return (height + margin.top - yScale(words[d]))});
//d3.select("rect").transition().delay(3);

var x = d3.select('svg').append('g')
		.call(xAxis)
		.attr('transform',"translate(" + margin.left.toString() + "," + (height+margin.top+5).toString() + ")");

x.selectAll('path').style({"fill":"none","stroke":"none"});
x.selectAll('line').style({"stroke":"black"});
var y = d3.select('svg').append('g')
		.call(yAxis)
		.attr('transform',"translate(" + margin.left.toString() + "," + margin.top.toString() +")");

//d3.select('g').append("text")
//	.attr("transform","rotate(-90)")
//	.attr("y",margin.left+20).attr("x",-20).style("text-anchor","end").text("Count");

d3.select('svg').append("text")
	.attr("x","45").attr("y","15").text("Count");
	//.attr("y",margin.left+20).attr("x",-20).style("text-anchor","end").text("Count");

y.selectAll('path').style({"fill":"none","stroke":"black"});
y.selectAll('line').style({"stroke":"black","fill":"black"});


//var tip = d3.tip()
//  .attr('class', 'd3-tip')
//  .offset([-10, 0])
//  .html(function(d) {
//    return "<strong>Frequency:</strong> <span style='color:red'>" + 33 + "</span>";
//  });
//
//svg.call(tip);
//d3.select("input").on("change", change);
//var sortTimeout = setTimeout(function() {
//    d3.select("input").property("checked", true).each(change); // some properties can only be modified by .property()
//  	}, 2000);
//function change() {
//
//	clearTimeout(sortTimeout);
//    // Copy-on-write since tweens are evaluated after a delay.
//    var x0 = xScale.domain(wordList.sort(this.checked
//		? function(a, b) { return b.frequency - a.frequency; }
//        : function(a, b) { return d3.ascending(a.letter, b.letter); })
//        .map(function(d) { return d.letter; }))
//        .copy();
//
//    svg.selectAll("rect")
//        .sort(function(a, b) { return x0(a.letter) - x0(b.letter); });
//
//    var transition = svg.transition().duration(750),
//        delay = function(d, i) { return i * 50; };
//
//    transition.selectAll("rect")
//        .delay(delay)
//        .attr("x", function(d) { return x0(d.letter); });
//
//    transition.select(".x.axis")
//        .call(xAxis)
//      .selectAll("g")
//        .delay(delay);
//  }

//var testinput = d3.select("input");
