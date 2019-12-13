# Script and Table Inventory
# Evan Kramer

# Set up
options(java.parameters = "-Xmx16G")
library(tidyverse)
library(lubridate)
library(haven)
library(readxl)
setwd(
  str_c("X:/Accountability/School Year ", 
        year(now()) - 1,
        "-",
        str_sub(year(now()), -2, -1),
        "/06 Analysis") # why 06? 
) 

# Get a list of all directories in accountability
(script_list = tibble(
  filepath = str_c(getwd(), "/", list.files(recursive = T))
) %>% 
  filter(str_detect(filepath, ".do")))