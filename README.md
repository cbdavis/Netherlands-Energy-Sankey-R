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
#sankeyPlot$show('inline', include_assets = TRUE, cdn = TRUE)
sankeyPlot$show('iframesrc', cdn = TRUE)
```

<iframe srcdoc=' &lt;!doctype HTML&gt;
&lt;meta charset = &#039;utf-8&#039;&gt;
&lt;html&gt;
  &lt;head&gt;
    &lt;link rel=&#039;stylesheet&#039; href=&#039;http://timelyportfolio.github.io/rCharts_d3_sankey/css/sankey.css&#039;&gt;
    
    &lt;script src=&#039;http://d3js.org/d3.v3.min.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;http://timelyportfolio.github.io/rCharts_d3_sankey/js/sankey.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    
    &lt;style&gt;
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 900px;
      height: 400px;
    }  
    &lt;/style&gt;
    
  &lt;/head&gt;
  &lt;body &gt;
    
    &lt;div id = &#039;chart142078ffd4f7&#039; class = &#039;rChart rCharts_d3_sankey&#039;&gt;&lt;/div&gt;    
    &lt;!--Attribution:
Mike Bostock https://github.com/d3/d3-plugins/tree/master/sankey
Mike Bostock http://bost.ocks.org/mike/sankey/
--&gt;

&lt;script&gt;
(function(){
var params = {
 &quot;dom&quot;: &quot;chart142078ffd4f7&quot;,
&quot;width&quot;:    900,
&quot;height&quot;:    400,
&quot;data&quot;: {
 &quot;source&quot;: [ &quot;Renewable Energy&quot;, &quot;Renewable Energy&quot;, &quot;MSW&quot;, &quot;Extraction&quot;, &quot;Nuclear&quot;, &quot;MSW&quot;, &quot;Extraction&quot;, &quot;Extraction&quot;, &quot;Crude Oil&quot;, &quot;Coal&quot;, &quot;Renewable Energy&quot;, &quot;Imports&quot;, &quot;Extraction&quot;, &quot;Powerplants&quot;, &quot;Coal&quot;, &quot;Powerplants&quot;, &quot;Powerplants&quot;, &quot;Natural Gas&quot;, &quot;Coal&quot;, &quot;Oil Products&quot;, &quot;Bunker Oil&quot;, &quot;Imports&quot;, &quot;Natural Gas&quot;, &quot;Imports&quot;, &quot;Oil&quot;, &quot;Oil Products&quot;, &quot;Crude Oil&quot;, &quot;Natural Gas&quot;, &quot;Crude Oil&quot;, &quot;Extraction&quot;, &quot;Imports&quot;, &quot;Imports&quot;, &quot;Oil Products&quot; ],
&quot;target&quot;: [ &quot;Heat Production&quot;, &quot;Final Use&quot;, &quot;Final Use&quot;, &quot;Nuclear&quot;, &quot;Powerplants&quot;, &quot;Powerplants&quot;, &quot;MSW&quot;, &quot;Crude Oil&quot;, &quot;Heat Production&quot;, &quot;Final Use&quot;, &quot;Powerplants&quot;, &quot;Electricity&quot;, &quot;Renewable Energy&quot;, &quot;Heat Production&quot;, &quot;Powerplants&quot;, &quot;Electricity&quot;, &quot;Waste Heat&quot;, &quot;Powerplants&quot;, &quot;Export&quot;, &quot;Bunker Oil&quot;, &quot;Final Use&quot;, &quot;Natural Gas&quot;, &quot;Final Use&quot;, &quot;Coal&quot;, &quot;Final Use&quot;, &quot;Oil&quot;, &quot;Export&quot;, &quot;Export&quot;, &quot;Oil Products&quot;, &quot;Natural Gas&quot;, &quot;Oil Products&quot;, &quot;Crude Oil&quot;, &quot;Export&quot; ],
&quot;value&quot;: [ 16, 17, 20, 28, 28, 34, 56, 65, 65, 75, 102, 120, 135, 207, 248, 346, 386, 492, 675, 676, 676, 810, 884, 1063, 1188, 1188, 1816, 2007, 2341, 2587, 3793, 4157, 4292 ] 
},
&quot;nodeWidth&quot;:     10,
&quot;nodePadding&quot;:     20,
&quot;layout&quot;:    900,
&quot;id&quot;: &quot;chart142078ffd4f7&quot; 
};

params.units ? units = &quot; &quot; + params.units : units = &quot;&quot;;

//hard code these now but eventually make available
var formatNumber = d3.format(&quot;0,.0f&quot;),    // zero decimal places
    format = function(d) { return formatNumber(d) + units; },
    color = d3.scale.category20();

if(params.labelFormat){
  formatNumber = d3.format(&quot;.2%&quot;);
}

var svg = d3.select(&#039;#&#039; + params.id).append(&quot;svg&quot;)
    .attr(&quot;width&quot;, params.width)
    .attr(&quot;height&quot;, params.height);
    
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
    nodes.push({ &quot;name&quot;: data.source[i] });
    nodes.push({ &quot;name&quot;: data.target[i] });
    links.push({ &quot;source&quot;: data.source[i], &quot;target&quot;: data.target[i], &quot;value&quot;: +data.value[i] });
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
    nodes[i] = { &quot;name&quot;: d };
});

sankey
  .nodes(nodes)
  .links(links)
  .layout(params.layout);
  
var link = svg.append(&quot;g&quot;).selectAll(&quot;.link&quot;)
  .data(links)
.enter().append(&quot;path&quot;)
  .attr(&quot;class&quot;, &quot;link&quot;)
  .attr(&quot;d&quot;, path)
  .style(&quot;stroke-width&quot;, function (d) { return Math.max(1, d.dy); })
  .sort(function (a, b) { return b.dy - a.dy; });

link.append(&quot;title&quot;)
  .text(function (d) { return d.source.name + &quot; → &quot; + d.target.name + &quot;\n&quot; + format(d.value); });

var node = svg.append(&quot;g&quot;).selectAll(&quot;.node&quot;)
  .data(nodes)
.enter().append(&quot;g&quot;)
  .attr(&quot;class&quot;, &quot;node&quot;)
  .attr(&quot;transform&quot;, function (d) { return &quot;translate(&quot; + d.x + &quot;,&quot; + d.y + &quot;)&quot;; })
.call(d3.behavior.drag()
  .origin(function (d) { return d; })
  .on(&quot;dragstart&quot;, function () { this.parentNode.appendChild(this); })
  .on(&quot;drag&quot;, dragmove));

node.append(&quot;rect&quot;)
  .attr(&quot;height&quot;, function (d) { return d.dy; })
  .attr(&quot;width&quot;, sankey.nodeWidth())
  .style(&quot;fill&quot;, function (d) { return d.color = color(d.name.replace(/ .*/, &quot;&quot;)); })
  .style(&quot;stroke&quot;, function (d) { return d3.rgb(d.color).darker(2); })
.append(&quot;title&quot;)
  .text(function (d) { return d.name + &quot;\n&quot; + format(d.value); });

node.append(&quot;text&quot;)
  .attr(&quot;x&quot;, -6)
  .attr(&quot;y&quot;, function (d) { return d.dy / 2; })
  .attr(&quot;dy&quot;, &quot;.35em&quot;)
  .attr(&quot;text-anchor&quot;, &quot;end&quot;)
  .attr(&quot;transform&quot;, null)
  .text(function (d) { return d.name; })
.filter(function (d) { return d.x &lt; params.width / 2; })
  .attr(&quot;x&quot;, 6 + sankey.nodeWidth())
  .attr(&quot;text-anchor&quot;, &quot;start&quot;);

// the function for moving the nodes
  function dragmove(d) {
    d3.select(this).attr(&quot;transform&quot;, 
        &quot;translate(&quot; + (
                   d.x = Math.max(0, Math.min(params.width - d.dx, d3.event.x))
                ) + &quot;,&quot; + (
                   d.y = Math.max(0, Math.min(params.height - d.dy, d3.event.y))
                ) + &quot;)&quot;);
        sankey.relayout();
        link.attr(&quot;d&quot;, path);
  }
})();
&lt;/script&gt;
    
    &lt;script&gt;&lt;/script&gt;    
  &lt;/body&gt;
&lt;/html&gt; ' scrolling='no' frameBorder='0' seamless class='rChart  http://timelyportfolio.github.io/rCharts_d3_sankey  ' id='iframe-chart142078ffd4f7'> </iframe>
 <style>iframe.rChart{ width: 100%; height: 400px;}</style>

```r
# save the image as a standalone html file
sankeyPlot$save('StandAloneSankey.html', standalone = TRUE)
```

```
Loading required package: base64enc
```
