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
a=paste("00",mois_courant,sep="")
a
mois<-substr(a,nchar(a)-1,nchar(a))
mois
file<-paste("rpu",annee_courante,"d01",mois,".Rda",sep="")

print(paste("Fichier courant: ",file,sep=""))

source(paste(path,"mes_fonctions.R",sep=""))

#'@name foo
#'@description retourne d1, ensemble de toutes les observations
#'@usage d1<-foo(path,file)
#'@param path chemin d'accès au fichier d01
#'@param file nom de fichier courant
#'
foo<-function(path="",file=""){
    if(!exists("d1")) {
      load(paste(path,"rpu2013d0109.Rda",sep=""))
      d1<-d0109
      rm(d0109)
    }
    d1<-d1[d1$ENTREE<"2013-10-01",]
    return (d1)
}

