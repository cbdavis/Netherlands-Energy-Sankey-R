#never ever ever convert strings to factors
options(stringsAsFactors = FALSE)

library(rCharts)
library(dplyr)

df = read.csv("NLEnergyFlows.csv")

colnames(df) <- c("source","target","value")
df$source <- as.character(df$source)
df$target <- as.character(df$target)

df = df %>% arrange(desc(value))

# See http://blog.ouseful.info/2013/07/23/generating-sankey-diagrams-from-rcharts/
# Only need the part at the bottom.  The main idea is that you need to have a CSV spreadsheet
# where there are three columns representing the source, target and value of the flow between those two


sankeyPlot <- rCharts$new()
sankeyPlot$setLib('http://timelyportfolio.github.io/rCharts_d3_sankey')

# if code doesn't work, download the code from https://github.com/timelyportfolio/rCharts_d3_sankey
# and set up the paths as shown in the commented lines below
#sankeyPlot$setLib('/home/cbdavis/Desktop/svn/rCharts_d3_sankey/libraries/widgets/d3_sankey')
#sankeyPlot$setTemplate(script = '/home/cbdavis/Desktop/svn/rCharts_d3_sankey/libraries/widgets/d3_sankey/layouts/chart.html')

sankeyPlot$set(
  data = df,
  nodeWidth = 10,
  nodePadding = 20,
  layout = 1000,
  width = 1000,
  height = 400
)

# shows the image
sankeyPlot

sankeyPlot$save("sankey.html")