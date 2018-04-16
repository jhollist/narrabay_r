# Script for Narragansett Bay Commission R Workshop
# 2018-04-23
# Author: J. W. Hollister
#
# Purpose: The purpose of this document is to serve as motivating example, but 
# will also serve to structure the rest of this workshop in that we will see how 
# to work with and visualize data in R and combine code and documentation with R 
# Markdown. Additionally, the tools we will be using come from The Tidyverse 
# <https://tidyverse.org> which is an opinionated (but effective) way to think 
# about organizing and analyzing data in R.


# checks for packages to make sure they are installed
pkgs <- c("ggplot2", "RCurl", "dplyr", "tidyr", "readr", "plotly", "DT", "here",
          "stringr")
for(i in pkgs){
  if(!i %in% installed.packages()){
    install.packages(i)
  }
}

# Loads up packages from library (there are fancier ways, but this is explicit!)
library(ggplot2)
library(RCurl)
library(dplyr)
library(tidyr)
library(readr)
library(plotly)
library(DT)
library(lubridate)
library(stringr)
library(here)

# Get data from Narragansett Bay Commissions snapshots 

## Set starting and ending years 
year1 <- 2017
year2 <- 2018

## Build URL to access data from the specified year range
date_url <- paste0(year1,"/01/01 12:00 AM-",year2,"/12/31 11:59 PM")
date_url_enc <- curlEscape(date_url)
url <- paste0("http://snapshot.narrabay.com/app/Data/ExportCsv?page=1&p=Chl,pH,Temp,Z&t=",
              date_url_enc, 
              "&l=5,9,6,7,8,1,2,3,4")
narrabay_data<-read_csv(url)
  

# Manipulate Data

## Problem #1 - multiple variables in one column
## Problem #2 - data encoding (and separating out)
## Problem #3 - Might not actually need data every 15 minutes and at multiple
## layers

narrabay_tidy <- narrabay_data %>%
  rename_all(tolower) %>%
  mutate(layer = location) %>%
  mutate(location = str_extract(.$location, "\\(\\w+\\)")
         
         str_split(narrabay_data$location, " ",simplify = T)) 

Let's tidy up this dataset.

```{r tidy}
# separate location from layer
# separate date and time
# aggregate into hourly and surface:bottom average
datatable(narrabay_data)
```

## Visualize Data

Next step is to visualize the data.  Let's look at the association between average temperature and chlorophyll.

```{r plot_it, warning=FALSE, message=FALSE, eval=F}
ggplotly()
```


