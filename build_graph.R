## different approach
# create basic topology of network

# SKOS The Simple Knowledge Organization System distinguishes between two basic
# categories of semantic relation: hierarchical and associative. A hierarchical
# link between two concepts indicates that one is in some way more general
# ("broader") than the other ("narrower"). An associative link between two
# concepts indicates that the two are inherently "related", but that one is not
# in any way more general than the other.

# The class skos:Concept is the class of SKOS concepts.

# A SKOS concept can be viewed as an idea or notion; a unit of thought. However,
# what constitutes a unit of thought is subjective, and this definition is meant
# to be suggestive, rather than restrictive.

# I guess we should have human readable labels on the connections too, 
# 
# skos:narrower
# skos:broader # a broader B betekend a < b
# skos:related
# skos:inScheme
# skos:partof?
#   instance of 
# schema.org:BlogPosting # for individual posts, blog for entire thing
# schema.org:SoftwareSourceCode # for snippets
# schema.org:SoftwareApplication 
# schema.org:WebPage# more generic
# schema.org:Movie
# schema.org:TVSeries
# schema.org:Book
# schema.org:Chapter
# 
# schema.org:Dataset
library(tidygraph)
library(visNetwork)

source("graph_elements.R")

missing_tags <- work %>% filter(is.na(to)) %>% group_by(to_name) %>% tally(sort = TRUE)
edges %>% filter(is.na(to)) %>% pull(to_name) %>% unique()
edges %>% filter(is.na(from)) %>% pull(from_name) %>% unique()




graph<- as_tbl_graph(edges) %>% 
  activate(nodes) %>% left_join(nodes, by="name")

# this is redicoulyus. it does not know igraph.

visNetwork(nodes=nodes, edges=edges) %>% 
  visLayout(randomSeed = 124)

# make url logic 
# - for wikidata =https://www.wikidata.org/wiki/{}
# - for ds_ontolody=https://www.datascienceontology.org/concept/{}

# links<- jsonlite::fromJSON("https://links.rmhogervorst.nl/index.json") # does not exist yet



# turn blogs into  graph elements too.
# colnames(blogs)
# [1] "date"       "url"        "title"      "summary"   
# [5] "content"    "tags"       "difficulty" "post_type" 
# [9] "section" 

thing %>% 
  select(name, id) %>% 
  mutate(name = stringr::str_to_lower(name)) %>% 
  left_join(
    tagframe %>% 
      rename(name=key) %>% 
      mutate(name = stringr::str_to_lower(name)),
    by='name') %>% 
  arrange(desc(count))
# So I expect 22 posts linked to visualisation
# 14 to dplyr, 10 to python, 8 to docker, etc

# add blogs to nodes
blogs %>% select(title,tags, difficulty,post_type, date)
[1] "name"           "description"    "external_links" "python_pkg"    
[5] "r_pkg"          "main_topic"  
nodes %>% 
  bind_rows()