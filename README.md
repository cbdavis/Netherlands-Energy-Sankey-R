# Sankey Diagram of Energy Flows in the Netherlands
Chris Davis  
January 22, 2016  


```r
#never ever ever convert strings to factors
options(stringsAsFactors = FALSE)

# to install rCharts you must do this once:
#install.packages("devtools")
#require(devtools)
#install_github('ramnathv/rCharts')

library(rCharts)

df = read.csv("NLEnergyFlows.csv")

colnames(df) <- c("source","target","value")
df$source <- as.character(df$source)
df$target <- as.character(df$target)

# See http://blog.ouseful.info/2013/07/23/generating-sankey-diagrams-from-rcharts/
# Only need the part at the bottom.  The main idea is that you need to have a CSV spreadsheet
# where there are three columns representing the source, target and value of the flow between those two

sankeyPlot <- rCharts$new()
sankeyPlot$setLib('http://timelyportfolio.github.io/rCharts_d3_sankey')

sankeyPlot$set(
  data = df,
  nodeWidth = 10,
  nodePadding = 20,
  layout = 900,
  width = 900,
  height = 400
)
```


```r
sankeyPlot$show('inline', include_assets = TRUE, cdn = TRUE)
```

<link rel='stylesheet' href=http://timelyportfolio.github.io/rCharts_d3_sankey/css/sankey.css>
<script type='text/javascript' src=http://d3js.org/d3.v3.min.js></script>
<script type='text/javascript' src=http://timelyportfolio.github.io/rCharts_d3_sankey/js/sankey.js></script> 
 <style>
  .rChart {
    display: block;
    margin-left: auto; 
    margin-right: auto;
    width: 900px;
    height: 400px;
  }  
  </style>
<div id = 'chart13c566865655' class = 'rChart rCharts_d3_sankey'></div>
<!--Attribution:
Mike Bostock https://github.com/d3/d3-plugins/tree/master/sankey
Mike Bostock http://bost.ocks.org/mike/sankey/
-->

<script>
(function(){
var params = {
 "dom": "chart13c566865655",
"width":    900,
"height":    400,
"data": {
 "source": [ "Renewable Energy", "Renewable Energy", "MSW", "Extraction", "Nuclear", "MSW", "Extraction", "Extraction", "Crude Oil", "Coal", "Renewable Energy", "Imports", "Extraction", "Powerplants", "Coal", "Powerplants", "Powerplants", "Natural Gas", "Coal", "Oil Products", "Bunker Oil", "Imports", "Natural Gas", "Imports", "Oil", "Oil Products", "Crude Oil", "Natural Gas", "Crude Oil", "Extraction", "Imports", "Imports", "Oil Products" ],
"target": [ "Heat Production", "Final Use", "Final Use", "Nuclear", "Powerplants", "Powerplants", "MSW", "Crude Oil", "Heat Production", "Final Use", "Powerplants", "Electricity", "Renewable Energy", "Heat Production", "Powerplants", "Electricity", "Waste Heat", "Powerplants", "Export", "Bunker Oil", "Final Use", "Natural Gas", "Final Use", "Coal", "Final Use", "Oil", "Export", "Export", "Oil Products", "Natural Gas", "Oil Products", "Crude Oil", "Export" ],
"value": [ 16, 17, 20, 28, 28, 34, 56, 65, 65, 75, 102, 120, 135, 207, 248, 346, 386, 492, 675, 676, 676, 810, 884, 1063, 1188, 1188, 1816, 2007, 2341, 2587, 3793, 4157, 4292 ] 
},
"nodeWidth":     10,
"nodePadding":     20,
"layout":    900,
"id": "chart13c566865655" 
};

params.units ? units = " " + params.units : units = "";

//hard code these now but eventually make available
var formatNumber = d3.format("0,.0f"),    // zero decimal places
    format = function(d) { return formatNumber(d) + units; },
    color = d3.scale.category20();

if(params.labelFormat){
  formatNumber = d3.format(".2%");
}

var svg = d3.select('#' + params.id).append("svg")
    .attr("width", params.width)
    .attr("height", params.height);
    
var sankey = d3.sankey()
    .nodeWidth(params.nodeWidth)
    .nodePadding(params.nodePadding)
    .layout(params.layout)
    .size([params.width,params.height]);
    
var path = sankey.link();
    
var data = params.data,
    links = [],
    nodes = [];
    
//get all source and target into nodes
//will reduce to unique in the next step
//also get links in object form
data.source.forEach(function (d, i) {
    nodes.push({ "name": data.source[i] });
    nodes.push({ "name": data.target[i] });
    links.push({ "source": data.source[i], "target": data.target[i], "value": +data.value[i] });
}); 

//now get nodes based on links data
//thanks Mike Bostock https://groups.google.com/d/msg/d3-js/pl297cFtIQk/Eso4q_eBu1IJ
//this handy little function returns only the distinct / unique nodes
nodes = d3.keys(d3.nest()
                .key(function (d) { return d.name; })
                .map(nodes));

//it appears d3 with force layout wants a numeric source and target
//so loop through each link replacing the text with its index from node
links.forEach(function (d, i) {
    links[i].source = nodes.indexOf(links[i].source);
    links[i].target = nodes.indexOf(links[i].target);
});

//now loop through each nodes to make nodes an array of objects rather than an array of strings
nodes.forEach(function (d, i) {
    nodes[i] = { "name": d };
});

sankey
  .nodes(nodes)
  .links(links)
  .layout(params.layout);
  
var link = svg.append("g").selectAll(".link")
  .data(links)
.enter().append("path")
  .attr("class", "link")
  .attr("d", path)
  .style("stroke-width", function (d) { return Math.max(1, d.dy); })
  .sort(function (a, b) { return b.dy - a.dy; });

link.append("title")
  .text(function (d) { return d.source.name + " → " + d.target.name + "\n" + format(d.value); });

var node = svg.append("g").selectAll(".node")
  .data(nodes)
.enter().append("g")
  .attr("class", "node")
  .attr("transform", function (d) { return "translate(" + d.x + "," + d.y + ")"; })
.call(d3.behavior.drag()
  .origin(function (d) { return d; })
  .on("dragstart", function () { this.parentNode.appendChild(this); })
  .on("drag", dragmove));

node.append("rect")
  .attr("height", function (d) { return d.dy; })
  .attr("width", sankey.nodeWidth())
  .style("fill", function (d) { return d.color = color(d.name.replace(/ .*/, "")); })
  .style("stroke", function (d) { return d3.rgb(d.color).darker(2); })
.append("title")
  .text(function (d) { return d.name + "\n" + format(d.value); });

node.append("text")
  .attr("x", -6)
  .attr("y", function (d) { return d.dy / 2; })
  .attr("dy", ".35em")
  .attr("text-anchor", "end")
  .attr("transform", null)
  .text(function (d) { return d.name; })
.filter(function (d) { return d.x < params.width / 2; })
  .attr("x", 6 + sankey.nodeWidth())
  .attr("text-anchor", "start");

// the function for moving the nodes
  function dragmove(d) {
    d3.select(this).attr("transform", 
        "translate(" + (
                   d.x = Math.max(0, Math.min(params.width - d.dx, d3.event.x))
                ) + "," + (
                   d.y = Math.max(0, Math.min(params.height - d.dy, d3.event.y))
                ) + ")");
        sankey.relayout();
        link.attr("d", path);
  }
})();
</script>

```r
#sankeyPlot$show('iframesrc', cdn = TRUE)

# save the image as a standalone html file
sankeyPlot$save('StandAloneSankey.html', standalone = TRUE)
```

```
Loading required package: base64enc
```
