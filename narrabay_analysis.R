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
pkgs <- c("ggplot2", "RCurl", "dplyr", "tidyr", "readr", "plotly", "here",
          "stringr")
for(i in pkgs){
  if(!i %in% installed.packages()){
    install.packages(i)
  }
}

# Loads up packages from library (there are fancier ways, but this is explicit!)
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)
library(plotly)
library(lubridate)
library(stringr)
library(here)

# Get data from Narragansett Bay Commissions snapshots 
# Commented Out: Grab data live from snapshot.narrabay.com
# Set starting and ending years 
#year1 <- 2015
#year2 <- 2017
# Build URL to access data from the specified year range
#date_url <- paste0(year1,"/01/01 12:00 AM-",year2,"/12/31 11:59 PM")
#date_url_enc <- RCurl::curlEscape(date_url)
#url <- paste0("http://snapshot.narrabay.com/app/Data/ExportCsv?page=1&p=Chl,pH,Temp&t=",
#              date_url_enc, 
#              "&l=1,2,3,4,5,6,7,8,9")
#narrabay_data<-read_csv(url) 

# Read in Data
narrabay_data <- read_csv("narrabay_buoy_1517.csv") 

# Some basic QA
## Problem #1 - -7999 looks a bit like a missing data value - should prob use NA
narrabay_data_qa1 <- narrabay_data %>%
  mutate(Chl = case_when(Chl == -7999 ~ NA_real_,
                              TRUE ~ Chl),
         pH = case_when(pH == -7999 ~ NA_real_,
                             TRUE ~ pH),
         Temp = case_when(Temp == -7999 ~ NA_real_,
                               TRUE ~ Temp))

## Problem #2 EXTREMES!!!! 
### Negative chl?
### Negative pH?
### HOT water
narrabay_data_qa2 <- narrabay_data_qa1 %>%
  filter(Chl >= 0) %>%
  filter(pH >= 0 & pH <= 14) %>%
  filter(Temp < 40)

## Problem #1 - multiple variables in one column
## Problem #2 - date encoding
narrabay_tidy <- narrabay_data_qa2 %>%
  rename_all(tolower) %>%
  mutate(layer = str_extract(.$location, "\\(\\w+\\)"),
         location = str_extract(.$location, "\\w+")) %>%
  mutate(layer = str_extract(.$layer, "\\w+")) %>%
  mutate(date_time = mdy_hms(time)) %>%
  mutate(date = date(date_time)) 

# Visualize Data
time_series_gg <-  narrabay_tidy %>%
  filter(layer == "surface") %>%
  # Aggrgate to daily per location and per parameter
  group_by(date, location) %>%
  summarize(daily_chl = mean(chl),
            daily_ph = mean(ph),
            daily_temp = mean(temp)) %>%
  gather(parameter, measurement, daily_chl:daily_temp) %>%
  ggplot(aes(x = date, y = measurement)) +
  facet_grid(parameter~., scales = "free_y") +         
  geom_point(aes(group = location)) +
  theme_bw()
time_series_gg  

chla_temp_gg <- narrabay_tidy %>%
  filter(layer == "surface") %>%
  # Aggrgate to daily per location and per parameter
  group_by(date, location) %>%
  summarize(daily_chl = mean(chl),
            daily_ph = mean(ph),
            daily_temp = mean(temp)) %>%
  ggplot(aes(x = daily_temp, y = daily_chl)) +
  geom_point(aes(color = location, group = date)) +
  geom_smooth(method = "lm", color = "black") +
  facet_grid(location ~ .) +
  theme_bw() +
  scale_color_manual(values = c("darkblue", "darkred"))
chla_temp_gg

ggplotly(chla_temp_gg)


