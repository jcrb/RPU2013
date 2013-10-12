#' prologue
#' 
library("gdata")
library("rgrs")
library("lubridate")
library("rattle")
library("epicalc")
library("zoo")
library("xts")
library("xtable")
library("plotrix")
library("openintro")

#' Variables globales:
#' -------------------

mois_courant <- 9
annee_courante <- 2013
path <- "../../"

source(paste(path,"mes_fonctions.R",sep=""))

foo<-function(path=""){
    if(!exists("d1")) {
      load(paste(path,"rpu2013d0109.Rda",sep=""))
      d1<-d0109
      rm(d0109)
    }
    d1<-d1[d1$ENTREE<"2013-10-01",]
    return (d1)
}

