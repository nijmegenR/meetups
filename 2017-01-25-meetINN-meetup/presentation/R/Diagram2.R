###
# Create a graph with both nodes and edges
# defined, and, add some default attributes
# for nodes and edges
###

library(DiagrammeR)
library(gsheet)

edgeData2 <-
  gsheet2tbl(
    'https://docs.google.com/spreadsheets/d/1oX9qiwqBgiTJNjphtgsX8qEi8TdFukPTUMTOEJPsDeY/pub?gid=0&single=true&output=csv'
  )

nodeData2 <-
  gsheet2tbl(
    'https://docs.google.com/spreadsheets/d/1oX9qiwqBgiTJNjphtgsX8qEi8TdFukPTUMTOEJPsDeY/pub?gid=887688557&single=true&output=csv'
  )

edgeData2$From_node <- gsub(" ", "\n", edgeData2$From_node)
edgeData2$To_node <- gsub(" ", "\n", edgeData2$To_node)
nodeData2$Name <- gsub(" ", "\n", nodeData2$Name)
nodeData2$Text <- paste0(nodeData2$Text)

# Create a node data frame
nodes2 <-
  create_nodes(
    nodes = nodeData2$Name,
    label = FALSE,
    type = "lower",
    style = "filled",
    color = nodeData2$Color,
    shape = nodeData2$Shape,
    height = 0.5,
    width = 0.85,
    fixedsize = "true",
    fontsize = 10,
    data = nodeData2$Value,
    tooltip = nodeData2$Text
  )

edges2 <-
  create_edges(
    from = edgeData2$From_node,
    to = edgeData2$To_node,
    color = edgeData2$Color,
    rel = edgeData2$Value
  )

graph2 <-
  create_graph(
    nodes_df = nodes2,
    edges_df = edges2,
    graph_attrs = c("layout = neato", "tooltip = 'Beweeg over elementen voor meer informatie'"),
    node_attrs = "fontname = Helvetica",
    edge_attrs = "arrowsize = 0.8"
  )

# Examine the NDF within the
# graph object
graph2$nodes_df


graph2$edges_df