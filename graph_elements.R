library(dplyr)

main_topics <- c("Data Structures", "Data Science Topics", "Data Engineering Topics", "MLOps","Fairness (in ml)","Stoicism")
r_libraries <- c("tibble","purrr","vctrs","themis","dials","yardstick","igraph","tidygraph","ranger",
                 "rtweet","renv","plumber","magrittr","shiny","workflows","recipes","parsnip","tune","data.table",
                 "plotly", "rayshader", "rmarkdown")
python_packages <- c("dbt","dagster","airflow")


blogs<- jsonlite::fromJSON("https://blog.rmhogervorst.nl/index.json") 
blog_nodes <- blogs %>% 
  select(title, summary, post_type, url) %>% 
  mutate(external_links = purrr::map2(url, post_type, ~list(url=.x, post_type=.y))) %>% 
  rename(name=title, description=summary) %>% 
  select(name, description, external_links)

notes<- jsonlite::fromJSON("https://notes.rmhogervorst.nl/index.json")
note_nodes <- notes %>% 
  select(name=title,description=summary, url) %>% 
  mutate(external_links = purrr::map(url, ~list(url=.x, post_type="note"))) %>% 
  select(-url)
  

nodes <- tibble::tribble(
  ~name, ~description, ~external_links,
  "Data Structures", "High level topic from computer science", list(wikidata="Q175263"),
  "Graph","A data structure for networks", list(wikidata="Q2479726"),
  "dataframe", "Structure to represent two-dimensional tabular data with labeled axes (rows and columns)", list(wikidata="Q107420052"),
  "R", "the R language", list(wikidata="Q206904"),
  "Go", "",list(),
  "Bash", "",list(),
  'Python', "the Python language", list(),
  'SQL', "", list(),
  "HTML", 'hypertext markup language', list(wikidata="Q8811"),
  "Programming languages", "A very high overview of programming languages", list(wikidata="Q9143"),
  "Computer science terms" ,"", list(wikidata="Q66747126"),
  "python library","software library for the Python programming language",list(wikidata="Q29642950"),
  'R package', "A package/library of code for the R programming language",list(wikidata="Q73539779"),
  "Hugo", "The static site generator",list(wikidata="Q24415127"),
  ## ml related things
  "supervised model", "", list(wikidata="Q334384", ds_ontology="supervised-model"),
  "statistical model", "I'm borrowing the description from ds ontology here: '[...] their defining characteristic is that they are functions of the data, i.e., they are fit to observations'", list(ds_ontology='model', wikidata="Q3284399"),
  'Machine Learning (ml)', "",list(wikidata="Q2539"),
  "Data Science Topics", "", list(),
  'Machine learning on graphs', "For example link prediction", list(),
  "Visualization", "the art of making relations visible", list(),
  # todo
  "MLOps","",list(),
  "Data Engineering Topics", "",list(),
  "Software Engineering Topics", "",list(),
  "Functional Programming", "",list(wikidata="Q193076"),
  "Programming Paradigm", "", list(wikidata="Q188267"),
  "Object Oriented Programming", "",list(wikidata="Q79872"),
  "encapsulated OOP", "methods belong to objects or classes, and method calls typically look like object.method(arg1, arg2)",list(),
  "functional OOP", "methods belong to generic functions, and method calls look like ordinary function calls: generic(object, arg2, arg3)", list(),

  "Boosted Tree Models", "A generic collection of tree based methods with boosting",list(),
  "XGboost", "",list(),
  "LightGBM", "",list(),
  "Catboost", "",list(),
  "Fairness (in ml)", "A topic I care about a lot", list(),
  "logging","",list(),
  # 
  "Webtechnologies","",list(),
  "JavaScript","",list(),
  "D3","",list(),
  #
  "orchestration","",list(),
  "rinprod","",list(),
  "kubernetes","",list(),
  "devops","",list(),
  "production","",list(),
  "scheduling","",list(),
  "automation","",list(),
  "serverless","",list(),
  "development","",list(),  
  "modular projects","",list(),  
  "docker","",list(),
  "scraping", "a vital tool for anyone who wants to use data from the web", list(),
  # R-packages
  "data.table","",list(),
  "tidyverse", '',list(wikidata="Q60755534"),
  'tidymodels', "a set of packages for machine learning", list(),
  "tune","acilitate hyperparameter tuning for the tidymodels packages",list(url="https://tune.tidymodels.org/"),
  "readr", "tool to read in csv and similar fast", list(),
  "git", "version control software", list(),
  "parsnip","tidy, unified interface to models",list(url="https://parsnip.tidymodels.org/"),
  "recipes","dplyr-like pipeable sequences of feature engineering steps",list(url="https://recipes.tidymodels.org/"),
  "workflows","bundle together your pre-processing, modeling, and post-processing requests",list(url="https://workflows.tidymodels.org/"),
  "shiny","webserver for R",list(),
  "magrittr","pipe operator",list(),
  "plumber","webserver for R",list(),
  "renv","",list(),
  "rtweet","",list(),
  "rtoot","",list(),
  "ranger","Version of random forests",list(),
  "tidygraph","tidy API for graph/network manipulation",list(url="https://tidygraph.data-imaginist.com/"),
  "igraph","older graph api for graph/network manipulation",list(),
  "dplyr","",list(),
  "themis","",list(),
  "dials","infrastructure to create and manage values of tuning parameters for the tidymodels packages",list(url="https://dials.tidymodels.org/"),
  "yardstick","estimate how well models are working",list(url="https://yardstick.tidymodels.org/"),
  "vctrs","",list(),
  "purrr","",list(),
  "tibble","",list(),
  "glue","",list(),
  "tidyr","", list(),
  "plotly","", list(),
  "rayshader","", list(), 
  "rmarkdown","", list(),
  "github", "a closed source code public, social repository of code", list(wikidata="Q364"),
  "decision trees", "decision support tool that uses a tree-like model of decisions and their possible consequences", list(wikidata="Q831366"),
  "random forest", "combination of decision trees", list(wikidata="Q245748",ds_ontology="random-forest"),
  "ggplot2","An amazing graphing library",list(wikidata="Q326489"),
  "magick", "A wrapper around imagemagick to manipulate images", list(),
  "banana", "A package I build once to measure things into bananas", list(url="https://github.com/rmhogervorst/banana"),
  "idea","",list(),
  "hack","",list(),
  "DNS", "domain name system", list(),
  "inspiration","",list(), 
  # python packages
  "pandas", "the python library pandas", list(wikidata="Q15967387"),
  "polars", "the python library polars", list(),
  "dbt","an amazing analysis package for databases", list(),
  "dagster","an amazing scheduler", list(),
  "airflow","a super robust scheduler", list(),
  # other interests
  "maturity models","",list(),
  "Mental models","",list(wikidata="Q1851867"),
  "writing","",list(),
  "zettelkasten","",list(wikidata="Q196883"),
  "100DaysToOffLoad","The  point of #100DaysToOffload is to challenge you to publish 100 posts on your personal blog in a year.",list(url="https://100daystooffload.com/"),
  "knowledge organization system","", list(wikidata="Q6423319"),
  "physical", "Art or objects created in the real world", list(),
  "tools", "", list(),
  "philosophy", "Study of the truths and principles of being, knowledge, or conduct", list(wikidata="Q5891"),
  "robot", "mechanical or virtual artificial agent carrying out physical activities", list(wikidata="Q11012"),
  "Stoicism", "life philosopy",list(wikidata="Q48235"),
  # inspiration
  "Better Decision Making", "A topic I find super interesting", list(),
  #"decisions"
  "gif", "fileformat with property that it can act like a video", list(),
  "dependency management","",list(), 
  "code versioning", "", list(),
  "pipelines", "high level concept", list(),
  "webserver", "machine that serves webpages", list(),
  "versioning","high level concept",list(),
  "photos", "", list(),
  "music", "", list(),
  "3dprinting","", list(),
  "venv","python package to version your packages", list(),
  "flask","python web framework", list(),
  "data versioning","", list(),
  "model versioning","", list(),
  "feature engineering pipelines","", list(),
  "training pipelines","", list(),
  "deployment pipelines","", list(),
  "CI/CD", "Continuous integration and either continuous delivery or continuous deployment", list(wikidata="Q28136854"),
  "Continuous Training", "Continuous retraining of models", list(),
  "3dprinting","", list(),
  "database","tool to save and retrieve data", list(wikidata="Q8513"),
  "sonification", "turning information into sound", list(),
  "Dataset Creation", "generic topic for turning information into datasets", list(),
  "embeddings","", list(),
  "Auto Encoder", "Useful tool (neural network) to compress data", list(),
  "Compression", "reducing the amount of information into smaller representation", list(), 
  "Neural Network", "", list(wikidata="Q192776"),
  "one hot encoding","turning categorical data into numerics like 1, or 0", list(),
  "Security", "overarching theme of security", list(),
  "2fa", "2 factor authentication", list(),
  "ubuntu", "A flavor of linux", list(wikidata="Q381"),
  "linux", "a free and open operating system", list(wikidata="Q388"),
  "scifi", "Science fiction,  genre of fiction", list(wikidata="Q24925"),
  "osm", "open street map", list(wikidata="Q936"),
  "wikidata", "free knowledge graph hosted by Wikimedia and edited by volunteers", list(wikidata="Q2013"),
  "data-minimalisation", "reducing the amount of data you save", list(),
  "AI", "artificial intelligence, a confusing term because it invokes movie robots while it is actually a set of if else statements", list(),
  "e-books", "Electronic books", list(),
  "art","",list(wikidata="Q735"),
  "generative_art","Art where the image is created from a computer program",list(wikidata="Q1502032"),
  'musea',"",list(wikidata="Q33506"),
  "autononous cars","Cars that can handle (parts of their) tasks on their own without user intervention",list(),
  "bigquery","A massive data warehouse created by google",list(),
  "Operating systems (OS)", "oftware that manages computer hardware resources", list(wikidata="Q9135"),
  "datawarehouse", "system used for reporting and data analysis, as a core component of business intelligence", list(wikidata="Q193351"),
  "conferences","",list(),
  "useR","A yearly R conference", list(),
  "gh-actions", "github actions", list(),
  "movies","",list(),
  "twitter", "",list(),
  "drawing", "",list(),
  "mastodon","",list(),
  "IPv4", "Internet prototocol version 4", list(),
  "IPv6", "Internet protocol version 6", list(),
  "internet protocol", "", list(),
  "GCP", "Google Cloud Project, huge cloud provider", list(),
  "binary", "", list(),
  "netlify", "A web company", list(),
  "pushover", "A push service", list(),
  "ifttt", "If This Then That, an no longer free to use service that can connect things together", list(),
  "webhooks", "callback method http request", list(wikidata="Q2553302"),
  'images',"2d visualisations", list(),
  "advanced","mental model level", list(),
  "beginner", "mental model level", list(),
  "intermediate", "mental model level", list(),
  "ML risk reduction","things we can do to reduce risks", list(),
  "Machine learning risks", "Potential risks related to machine learning", list(),
  "reddit", "a social media", list(),
  "Social Media" ,  "", list(), 
  "autonomous cars", "vehicles, their sensors, and computers that make decisions without intervention of a human", list(), 
  "satRdays", "A one day conference", list(), 
  "meetup" ,  "short gathering", list(), 
  
) %>% 
  dplyr::rows_append(
    blog_nodes
  ) %>% 
  rows_append(note_nodes) %>% 
  mutate(
    python_pkg=case_when(name %in% python_packages ~ TRUE, TRUE~FALSE),
    r_pkg=case_when(name %in% r_libraries ~ TRUE, TRUE~FALSE),
    main_topic = case_when(name %in% main_topics ~ TRUE,TRUE~FALSE)
  ) %>% 
  mutate(id=dplyr::row_number()) %>% 
  mutate(
    label = name, #add labels on nodes
    title= name,#description, #tooltip (html or character), when the mouse is above
    shape = case_when(name %in% main_topics ~ "diamond",
                      name %in% blog_nodes$name ~ "triangle",
                      name %in% note_nodes$name ~ "triangle",
                      TRUE ~ "dot"),
    value = 1,
    color = case_when(
      r_pkg~"green",
      python_pkg~"yellow",
      name %in% main_topics ~ "grey",
      name %in% blog_nodes$name ~ "purple",
      name %in% note_nodes$name ~ "darkblue",
      TRUE~NA_character_),
    name_match = stringr::str_to_lower(name)
  )
node_id <- nodes %>% select(name_match, id)

# make connection from blogposts/notes to tags
work <- 
  bind_rows(
    blogs %>% select(name=title, tags),
    notes %>% select(name=title, tags),
  ) %>% 
  mutate(name_low = stringr::str_to_lower(name)) %>% 
  left_join(node_id, by=c("name_low"="name_match")) %>%
  mutate(relation="tagged as") %>% 
  rename(from=id, from_name=name) %>% 
  select(-name_low) %>% 
  tidyr::unnest(tags) %>% 
  filter(tags != "") %>% 
  mutate(
    to_name = stringr::str_to_lower(tags),
    
    to_name = case_when(
      # modify tag write to writing
      to_name == "write" ~ "writing",
      # modify package to r package
      to_name == "package" ~ "r package",
      # modify hardware to physical
      to_name == "hardware" ~ "physical",
      to_name == "boostedtreemethods"~ "boosted tree models",
      to_name == "boostedtreemodels"~ "boosted tree models",
      to_name == "bot"~ "robot",
      to_name == "stoic" ~ "stoicism",
      to_name == "data_science" ~ "data science topics",
      to_name == "decisions" ~ "better decision making",
      to_name == "version control" ~ "code versioning",
      to_name == "ebooks" ~ "e-books",
      to_name == "eboooks" ~ "e-books",
      to_name == "machinelearning" ~ "machine learning (ml)",
      to_name == "visualisation" ~ "visualization",
      to_name == "fairness" ~ "fairness (in ml)",
      to_name == "user2021" ~ "user",
      to_name == "user2017" ~ "user",
      to_name == "ip4" ~ "ipv4",
      to_name == "ip6" ~ "ipv6",
      TRUE ~ to_name
      )
    ) %>% 
  left_join(
    node_id %>% 
      mutate(
        to_name=name_match,
        to = id
        ) %>% 
      select(to_name, to), 
    by = "to_name")
  

edges <- tibble::tribble(
  # subject, predicate, object
  ~from, ~relation, ~to,
  "Data Structures", "rdf:type", "skos:Concept",
  "XGboost","skos:narrower", "Boosted Tree Models",
  "LightGBM","skos:narrower", "Boosted Tree Models",
  "Catboost", "skos:narrower", "Boosted Tree Models",
  "Graph", "skos:inScheme", "Data Structures",
  "dataframe", "skos:inScheme", "Data Structures",
  "supervised model","skos:narrower", "statistical model",
  "supervised model", "part of", "Machine Learning (ml)",
  "Machine Learning (ml)","skos:narrower", "Data Science Topics",
  "Visualisation", "skos:narrower","Data Science Topics",
  "production", "part of", "Data Engineering Topics",
  "production", "part of", "MLOps",
  "versioning", "part of", "MLOps",
  # 
  "MLOps","skos:narrower","Data Science Topics",
  "MLOps","skos:narrower","Software Engineering Topics",
  "MLOps","skos:narrower","Data Engineering Topics",
  "Fairness (in ml)", "skos:narrower","Data Science Topics",
  ## topics that are connected but not hierarchical
  "supervised model","skos:related","Machine learning on graphs", 
  "Graph","skos:related","Machine learning on graphs", 
  "random forest","skos:narrower","decision trees",
  "Boosted Tree Models","skos:narrower","decision trees",
  "decision trees","skos:narrower","supervised model",
  "Neural Network", "skos:narrower","supervised model",
  
  "zettelkasten", "skos:narrower", "knowledge organization system",
  "rtweet","skos:related","Dataset Creation",
  "rtoot","skos:related","Dataset Creation",
  "mastodon", "skos:narrower", "Social Media",
  "twitter", "skos:narrower", "Social Media",
  "reddit", "skos:narrower", "Social Media",
  "rtweet", "skos:related", "twitter",
  "rtoot", "skos:related", "mastodon",
  

  # mlops as combination of computer science, machine learning, data engineering
   "Programming Paradigm" ,"skos:inScheme","Software Engineering Topics",
   "Object Oriented Programming" ,"skos:inScheme", "Programming Paradigm",
   "Functional Programming" ,"skos:inScheme", "Programming Paradigm",
   "functional OOP",  "skos:narrower","Functional Programming",
   "encapsulated OOP", "skos:narrower","Functional Programming",
  
  # languages
  "Programming languages", "skos:inScheme", "Computer science terms",
  "R","skos:inScheme", "Programming languages",
  "Python","skos:inScheme", "Programming languages",
  "Bash","skos:inScheme", "Programming languages",
  "Go","skos:inScheme", "Programming languages",
  "JavaScript", "skos:inScheme", "Programming languages",
  "SQL", "skos:inScheme", "Programming languages",
  #
  "python library", "programmed in", "Python",
  "R package", "programmed in", "R",
  "Hugo", "programmed in", "Go",
  "Webtechnologies", "part of", "Computer science terms",
  "JavaScript","skos:narrower", "Webtechnologies",
  "HTML","skos:narrower", "Webtechnologies",
  "DNS", "part of", "Webtechnologies",
  "D3", "programmed in", "JavaScript",
  "D3", "skos:related", "Visualisation",
  
  # python packages
  "pandas","instance of", "python library",
  "polars","instance of", "python library",
  ## R packages
  "tidyverse", "instance of", "R package",
  "dplyr", "instance of", "R package",
  "dplyr", "part of", "tidyverse",
  "tidyr", "part of", "tidyverse",
  "tibble", "part of", "tidyverse",
  "readr", "part of", "tidyverse",
  # tidymodels
  "tidymodels", "instance of", "R package",
  "themis", "part of", "tidymodels",
  "yardstick", "part of", "tidymodels",
  "dials", "part of", "tidymodels",
  "tune", "part of", "tidymodels",
  "parsnip", "part of", "tidymodels",
  "workflows", "part of", "tidymodels",
  "recipes", "part of", "tidymodels",
  "ranger", "used_with", "tidymodels",
  "lightgbm", "used_with", "tidymodels",
  "catboost", "used_with", "tidymodels",
  "tidymodels", "skos:related", "supervised model",
  "catboost","skos:narrower","Boosted Tree Models",
  "lightgbm","skos:narrower","Boosted Tree Models",
  "xgboost","skos:narrower","Boosted Tree Models",
  "ranger", "instance of","random forest",
  # unconnected
  "production", "part of", "Data Engineering Topics",
  "production", "part of", "MLOps",
  "logging" ,"part of", "MLOps",
  "automation" ,"part of", "MLOps",
  "logging" ,"part of", "devops",
  "automation" ,"part of", "devops",
  "serverless" ,"part of", "devops",
  "kubernetes" ,"part of", "devops",
  "docker", "part of","devops",
  'rinprod', 'skos:narrower',"production",
  'rinprod', 'programmed in',"R",
  "scheduling", "part of", "MLOps",
  "orchestration", "part of", "MLOps",
  "devops", "skos:related", "Data Engineering Topics",
  "scraping", "part of", "Webtechnologies",
  "webserver", "part of", "Webtechnologies",
  "dagster", "used for", "orchestration",
  "dagster", "used for", "scheduling",
  "airflow", "used for", "orchestration",
  "airflow", "used for", "scheduling",
  "scheduling",'skos:related',"orchestration",
  # packages
  "purrr", "instance of", "R package",
  "igraph","instance of", "R package",
  "tidygraph","instance of", "R package",
  "vctrs","instance of", "R package",
  "plumber","instance of", "R package",
  "renv", "instance of", "R package",
  "data.table", "instance of", "R package",
  "magrittr", "instance of", "R package",
  "shiny", "instance of", "R package",
  "rtweet", "instance of", "R package",
  "polars", "skos:related","dataframe",
  "pandas", "skos:related","dataframe",
  "data.table","skos:related","dataframe",
  "tibble","skos:related","dataframe",
  
  "Boosted Tree Models","skos:related","dataframe",
  "database", "part of","Computer science terms",
  "ggplot2", "skos:related", "Visualisation",
  
  # usecases
  "renv", "used for","dependency management",
  "venv", "used for","dependency management",
  "purrr", "used for", "Functional Programming",
  'plumber', "instance of","webserver",
  'shiny', "instance of","webserver",
  'flask', "instance of","webserver",
  "flask", "instance of", "python library",
  "venv", "instance of", "python library",
  "dbt", "instance of", "python library",
  "dbt", "skos:related", "SQL",
  "docker", "skos:related","kubernetes",
  "airflow",  "instance of", "python library",
  "dagster", "instance of", "python library",
  ## other interests
  ## writing, hardware
  "maturity models", "part of",  "Mental models",
  "data versioning", "skos:narrower","versioning",
  "code versioning", "skos:narrower","versioning",
  "model versioning", "skos:narrower","versioning",
  "git", "used for", "code versioning",
  "training pipelines", "skos:narrower", "pipelines",
  "deployment pipelines", "skos:narrower", "pipelines",
  "feature engineering pipelines", "skos:narrower", "pipelines",
  "pipelines", "part of", "MLOps",
  # music - physical
  "music", "skos:related", "physical",
  # photos - physical
  "photos", "skos:related", "physical",
  "images", "skos:related", "physical",
  "drawing", "skos:related", "physical",
  "movies", "skos:related", "images",
  "3dprinting", "skos:related", "physical",
  
  
  "CI/CD", "skos:related",  "deployment pipelines", 
  "Continuous Training", "skos:related", "deployment pipelines" , 
  "Continuous Training", "skos:related", "training pipelines", 
  "Better Decision Making", "skos:related", "Data Science Topics",
  "sonification", "skos:related", "Dataset Creation",
  "embeddings", "skos:related","Dataset Creation",
  "one hot encoding", "skos:related", "Dataset Creation",
  "Dataset Creation", "part of", "Data Science Topics",
  # stoicsm 
  "Stoicism", "skos:narrower","philosophy",
  "Auto Encoder", "skos:narrower", "Neural Network", 
  "Auto Encoder", "skos:related", "Compression",
  
  "mental models", "skos:related", "beginner",
  "mental models", "skos:related", "advanced",
  "mental models", "skos:related", "intermediate",
  
  "2fa", "part of", "Security",
  "Security", "skos:related", "devops",
  "systemd", "part of", "linux",
  "ubuntu", "flavor of", "linux",
  "DNS", "part of", "Computer science terms",
  "Operating systems (OS)", 'part of', "Computer science terms",
  "linux", "instance of", "Operating systems (OS)",
  "osm", "skos:related", "Dataset Creation",
  "wikidata", "skos:related", "Dataset Creation",
  "AI", "skos:related", 'scifi',
  "AI", "skos:related", 'Machine Learning (ml)',
  "autonomous cars", "skos:related", 'Machine Learning (ml)',
  "Machine learning risks", "skos:related", 'Machine Learning (ml)',
  "Machine learning risks", "opposite", 'ML risk reduction',
  "data-minimalisation","skos:related", 'Machine Learning (ml)',
  "generative_art", "skos:narrower","art",
  "bigquery", "instance of", "datawarehouse",
  "datawarehouse", "skos:related", "database",
  # 
  "IPv4", "has edition", "internet protocol",
  "IPv6", "has edition", "internet protocol",
  "internet protocol", "part of", "Webtechnologies",
  "GCP", "skos:related", "Webtechnologies",
  "netlify", "skos:related", "Webtechnologies",
  "pushover", "skos:related", "Webtechnologies",
  "ifttt", "skos:related", "Webtechnologies",
  "webhooks", "skos:related", "Webtechnologies",
  
  # other things
  "modular projects", "skos:related", "MLOPS",
  "development", "skos:related", "devops",
  "useR", "instance of", "conferences",
  "satRdays", "instance of", "conferences",
  "meetup", "skos:related", "conferences",
  "gh-actions", "instance of", "automation",
  "gh-actions", "skos:related", "github"
) %>% 
  mutate(
    from_ = stringr::str_to_lower(from),
    to_ = stringr::str_to_lower(to)
  ) %>% 
  left_join(
    node_id, by=c("from_"="name_match")
    ) %>% 
  rename(from_name="from",from="id") %>% 
  left_join(
    node_id, by=c("to_"="name_match")
    ) %>% 
  rename(to_name="to",to="id") %>% 
  select(from_name, relation, to_name, from, to) %>% 
  # Add my work to it
  dplyr::rows_append(
    work %>% 
      select(from_name, relation, to_name, from, to) %>% 
      filter(!is.na(to))
  ) %>% 
  # add visnetwork specifics
  mutate(
    # arrows
    arrows = case_when(
      relation == "skos:related" ~ "to;from",
      TRUE ~ "from"
    ),
    label = relation,
    # width
    # title
    # dashes
    dashes = case_when(relation =="skos:related" ~ TRUE,
                       TRUE ~ FALSE)
  )

