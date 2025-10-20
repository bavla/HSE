# Structured weights
# Vladimir Batagelj
# October 19, 2025

setwd("C:/Users/Public/Sunbelt25")



# -------------------------------------------------------------------------

> setwd("C:/Users/Public/Sunbelt25")
> library(igraph); library(jsonlite); library(httr)
> source(paste0("https://raw.githubusercontent.com/bavla/",
+   "Nets/refs/heads/master/netsWeight/netsWeight.R"))
> G <- graph_from_literal(Ann-+Chris, Ann-+Bill, Ann+-Dan, Dan+-Chris, Bill++Dan)
> V(G)$x <- c(2,2,8,8); V(G)$y <- c(8,2,8,2)
> G$name <- "Struct1"; G$tit <- "Structured weights - test 1"
> G$by <- "Vladimir Batagelj"; G$date <- date()
> V(G)$cy <- vector("list",4)
> V(G)$cy[[1]] <- c("SI", "US", "FR"); V(G)$cy[[4]] <- c("UK")
> V(G)$cy[[2]] <- c("US", "UK"); V(G)$cy[[3]] <- c("IT", "SI")
> G
IGRAPH 60e8c4f DN-- 4 6 -- Struct1
+ attr: name (g/c), tit (g/c), by (g/c), date (g/c), name (v/c), x
| (v/n), y (v/n), cy (v/x)
+ edges from 60e8c4f (vertex names):
[1] Ann  ->Chris Ann  ->Bill  Chris->Dan   Bill ->Dan   Dan  ->Ann   Dan  ->Bill 
> 

> plot(G)
> graph_attr(G)
> (nodes <- as_data_frame(G,what="vertices"))
> saveRDS(G,file="Struct1.rds")
> write_graph_netsJSON(G,file="Struct1.json")

> V(G)$cy[[3]] <- matrix(1:4,nrow=2)
> V(G)$cy[[2]] <- data.frame(b=c(3,7),e=c(5,14),v=c("P","Q"))
> V(G)$cy[[4]] <- list(m=TRUE,k=35)
> (nodet <- as_data_frame(G,what="vertices"))
> nodet$cy[2][[1]]
> toString(nodet$cy[2][[1]])
> write_graph_netsJSON(G,file="Testr.json")

> H <- netsJSON_to_graph(fromJSON("Testr.json"),directed=TRUE)
> (nodeh <- as_data_frame(H,what="vertices"))
       name x y                cy
Ann     Ann 2 8        SI, US, FR
Chris Chris 2 2 3, 7, 5, 14, P, Q
Bill   Bill 8 8        1, 2, 3, 4
Dan     Dan 8 2             1, 35
> nodeh$cy[[1]]
> nodeh$cy[[2]][[1]]
> nodeh$cy[[3]][1,,]
> nodeh$cy[[4]]

> library(tidyverse)
> T <- as_tibble(nodeh)
> glimpse(T)
Rows: 4
Columns: 4
$ name <chr> "Ann", "Chris", "Bill", "Dan"
$ x    <int> 2, 2, 8, 8
$ y    <int> 8, 2, 8, 2
$ cy   <list> <"SI", "US", "FR">, [[<data.frame[2 x 3]>]], <<array[1 x 2 x 2]>>,…
> T
# A tibble: 4 × 4
  name      x     y cy               
  <chr> <int> <int> <list>           
1 Ann       2     8 <chr [1 × 3]>    
2 Chris     2     2 <list [1]>       
3 Bill      8     8 <int [1 × 2 × 2]>
4 Dan       8     2 <df [1 × 2]>     
> 




