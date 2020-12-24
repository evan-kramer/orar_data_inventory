# ORAR (Brute Force) Data Inventory
# Evan Kramer
# 12/15/2020

# Set up
options(java.parameters = "-Xmx16G")
installed_packages = as.data.frame(installed.packages())
required_packages = c("tidyverse", "lubridate", "httr", "rjson", "odbc", "rvest", "xml2",
                      "XML", "jsonlite", "data.table", "curl", "readxl", "DBI", "RJDBC",
                      "dbplyr")
for(p in required_packages) {
  if(!p %in% installed_packages$Package) {
    install.packages(p)
  }
  library(p, character.only = T)
}
rm(list = ls(pattern = "_packages"))
con = dbConnect(odbc(), Driver = "SQL Server", Server = "OSSEDAARPRD02", 
                Database = "master", Trusted_Connection = "True")

# Get databases
dbGetQuery(
  con, 
  "SELECT *
  FROM sys.databases"
) %>% 
  as_tibble()
