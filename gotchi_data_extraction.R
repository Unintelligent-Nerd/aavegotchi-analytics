#setting up API key
Sys.setenv(GOTCHI_KEY = "WT8J3FDTQHK58XXJNTPIEAS6ZYVZAFPE67")
Sys.getenv("GOTCHI_KEY")

#looking into the api key further
library("rromeo")
rr_auth("QmU7etkLL4MzTyJmaNtUd95YGj1J1iSLPdcfkCdsXzAwQz")
check_key()

#Loading the necessary packages for working with APIs
install.packages("XML")
library(httr)
library(jsonlite)
library(htmltools)
library(XML)
#using the API to request data
res = GET("https://api.thegraph.com/subgraphs/name/cinnabarhorse/aavegotchi-mumbai")
res

#converting the code into something useful from the api pull
rawToChar(res$content)

#using html tools to convert output into data
data = XML::htmlParse(res)
data
