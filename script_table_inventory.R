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

# Connect to database 
# use "# delimit ;" AND "# delimit cr"

# Get a list of all directories in accountability
script_list = tibble(
  file_path = str_c(getwd(), "/", list.files(recursive = T))
)  

filter(script_list, str_detect(file_path, ".do")) %>% 
  mutate(
    max(str_locate_all(file_path, "/")),
    script_name = NA_character_,
    date_last_modified = file.mtime(file_path)
  )

for(f in script_list$file_path[1:3]) {
  read_lines(f) %>% 
    str_flatten() %>% 
    str_locate_all("dsn") %>%
    print()
}
