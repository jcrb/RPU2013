# fonction summaries()

summaries<-function()
{

}

# passages(hop,hop_mame="CH",main="",col="")

# hop (character) = Finess de l'établissement
# sens 1 = entrées, 2 = sorties, 3 = entrées et sorties
passages<-function(hop,hop_name="CH",col="blue",sens=1,main="")
{
  require("lubridate")
  hop<-d1[d1$FINESS==hop,]
  if(main==""){main=hop_name}
  if(sens==1){
    e<-ymd_hms(hop$ENTREE)
    col="blue"
    t2<-as.integer(table(hour(e)))
    t4<-prop.table(t2)
    legende<-"Entrées"
  }
  else if(sens==2){
    e<-ymd_hms(hop$SORTIE)
    col="red"
    t2<-as.integer(table(hour(e)))
    t4<-prop.table(t2)
    legende<-"Sorties"
  }
  else if(sens==3){
    e<-ymd_hms(hop$ENTREE)
    s<-ymd_hms(hop$SORTIE)
    col<-c("red","blue")
    te<-as.integer(table(hour(e)))
    ts<-as.integer(table(hour(s)))
    t4<-rbind(prop.table(te),prop.table(ts))
    legende<-c("Entrées","Sorties")
  }

  clock24.plot(t4,clock.pos=1:24,rp.type="p",main=main,show.grid.labels=F,line.col=col,radial.lim=c(0,0.1))
  legend(0.09,-0.09,legende,col=col,lty=1,cex=0.8)
}

mysql2resural<-function(an,mois)
{
  first<-paste(an,mois,"01",sep="-")
  last<-paste(an,mois,"31",sep="-")
  query<-paste("SELECT * FROM RPU__ WHERE ENTREE BETWEEN '",first,"' AND '",last,"'",sep="")
  con<-dbConnect(MySQL(),group = "rpu")
  # rs<-dbSendQuery(con,"SELECT * FROM RPU__ WHERE ENTREE BETWEEN 2013-06-01 AND 2013-06-31")
  rs<-dbSendQuery(con,query)
  d06<-fetch(rs,n=-1,encoding = "UTF-8")
  # nettoyage
  d06<-d06[,-16]
  a<-d06$FINESS
  a[a=="670000397"]<-"Sel"
  a[a=="680000684"]<-"Col"
  a[a=="670016237"]<-"Odi"
  a[a=="670000272"]<-"Wis"
  a[a=="680000700"]<-"Geb"
  a[a=="670780055"]<-"Hus"
  a[a=="680000197"]<-"3Fr"
  a[a=="680000627"]<-"Mul"
  a[a=="670000157"]<-"Hag"
  a[a=="680000320"]<-"Dia"
  a[a=="680000395"]<-"Alk"
  unique(a)
  d06$FINESS<-as.factor(a)
  rm(a)
  d06$CODE_POSTAL<-as.factor(d06$CODE_POSTAL)
  d06$COMMUNE<-as.factor(d06$COMMUNE)
  d06$SEXE<-as.factor(d06$SEXE)
  d06$TRANSPORT<-as.factor(d06$TRANSPORT)
  d06$TRANSPORT_PEC<-as.factor(d06$TRANSPORT_PEC)
  d06$GRAVITE<-as.factor(d06$GRAVITE)
  d06$ORIENTATION<-as.factor(d06$ORIENTATION)
  d06$MODE_ENTREE<-factor(d06$MODE_ENTREE,levels=c(0,6,7,8),labels=c('NA','Mutation','Transfe  rt','Domicile'))
  d06$PROVENANCE<-factor(d06$PROVENANCE,levels=c(0,1,2,3,4,5,8),labels=c('NA','MCO','SSR','SLD','PSY','PEA','PEO'))
  d06$MODE_SORTIE<-factor(d06$MODE_SORTIE,levels=c(0,6,7,8,4),labels=c('NA','Mutation','Transfert','Domicile','Décès'))
  d06$DESTINATION<-factor(d06$DESTINATION,levels=c(0,1,2,3,4,6,7),labels=c('NA','MCO','SSR','SLD','PSY','HAD','HMS'))
  # Création d'une variable AGE:
  d06$AGE<-floor(as.numeric(as.Date(d06$ENTREE)-as.Date(d06$NAISSANCE))/365)
  # Correction des ages supérieurs à 120 ans (3 cas) ou inférieur à 0 (2 cas)
  d06$AGE[d06$AGE > 120]<-NA
  d06$AGE[d06$AGE < 0]<-NA
  # sauvegarde
  write.table(d06,"rpu2013_06.txt",sep=',',quote=TRUE,na="NA")
  save(d06,file="rpu2013d06.Rda")
}