# Extraction of a variable from the Factbook 

Here is an example how to obtain (in vector urate) the values of the variable ''unemployment_rate'' 
```
> library(jsonlite)
> fb <- "https://github.com/iancoleman/cia_world_factbook_api/raw/master/data/factbook.json"
> J <- fromJSON(readLines(fb))
> C <- names(J$countries)
> head(C)
[1] "world"          "afghanistan"    "akrotiri"       "albania"      
[5] "algeria"        "american_samoa"
> n <- length(C)
> urate <- rep(0,n)
> for(ci in 1:n){
+   ur <- J$countries[[ci]]$data$economy$unemployment_rate$annual_values
+   v <- ur$value[1]; d <- ur$date[1]
+   urate[ci] <- ifelse(is.null(v),NA,v)
+   year <- ifelse(is.null(d),"0000",d)
+   cat("U_rate:",format(ci,width=3,justify="r"),
+     format(urate[ci],width=7,nsmall=2),year,C[ci],"\n")
+ }
U_rate:   1    7.70 2017 world
U_rate:   2   23.90 2017 afghanistan
U_rate:   3      NA 0000 akrotiri
U_rate:   4    5.83 2019 albania
U_rate:   5   11.70 2017 algeria
U_rate:   6   29.80 2005 american_samoa
U_rate:   7    3.70 2016 andorra
U_rate:   8    6.60 2016 angola
...
U_rate: 257   15.00 2008 zambia
U_rate: 258   11.30 2014 zimbabwe
U_rate: 259    8.60 2016 european_union
>
</code>
For some countries, we get values for different years. In the example, we are using the most recent value.
You could use some more complicated selection of value - for example, the closest to the year 2017.

Here is another example for variable ''contraceptive_prevalence_rate''
<code>
> crate <- rep(0,n)
> for(ci in 1:n){
+   cr <- J$countries[[ci]]$data$people$contraceptive_prevalence_rate
+   v1 <- cr$value[1]
+   u <- cr$units[1]
+   d1 <- cr$date[1]
+   crate[ci] <- ifelse(is.null(v1),NA,v1)
+   year <- ifelse(is.null(d1),"0000",d1)
+   cat("C_rate:",format(ci,width=3,justify="r"),
+     format(crate[ci],width=7,nsmall=2),year,C[ci],"\n")
+ }
C_rate:   1      NA 0000 world
C_rate:   2   18.90 2018 afghanistan
C_rate:   3      NA 0000 akrotiri
C_rate:   4   46.00 2017 albania
C_rate:   5   57.10 2012 algeria
...
C_rate: 255      NA 0000 western_sahara
C_rate: 256   33.50 2013 yemen
C_rate: 257   49.50 2018 zambia
C_rate: 258   66.80 2015 zimbabwe
C_rate: 259      NA 0000 european_union
>
```

It is not a very good variable - it contains many NAs. Try to avoid such variables in your project.


