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
