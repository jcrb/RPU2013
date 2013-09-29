Motif de consultation
========================================================

Le motif de consultation est l'un des items les plus mal renseigné. Cela est du en partie à l'absence de règles formelles concernant la saisie de cet élément. Une recommandation du ministère de la santé demande que la thésaurus 2013 de la SFMU [ref.9] soit utilisé.

Le thésaurus est présenté sous la formed'un fichier Excel. L'onglet **recours** liste environ *150* motifs de recours aux urgences avec leur correspondance CIM10. Aucune méthode n'est parfaite mais cette page constitue une bonne base d'harmonisation des données.


```r
getwd()
```

```
## [1] "/home/jcb/Documents/Resural/Stat Resural/RPU2013/Chapitres/Motif"
```

```r
source("../prologue.R")

d1 <- foo(path)
names(d1)
```

```
##  [1] "id"            "CODE_POSTAL"   "COMMUNE"       "DESTINATION"  
##  [5] "DP"            "ENTREE"        "EXTRACT"       "FINESS"       
##  [9] "GRAVITE"       "MODE_ENTREE"   "MODE_SORTIE"   "MOTIF"        
## [13] "NAISSANCE"     "ORIENTATION"   "PROVENANCE"    "SEXE"         
## [17] "SORTIE"        "TRANSPORT"     "TRANSPORT_PEC" "AGE"
```


```r
print(annee_courante)
```

```
## [1] 2013
```

```r
print(mois_courant)
```

```
## [1] 9
```

```r
d1$MOTIF <- as.factor(d1$MOTIF)
```

Ensemble des hôpitaux
---------------------

```r

c <- tapply(!is.na(d1$MOTIF), d1$FINESS, mean)
round(c * 100, 2)
```

```
##    3Fr    Alk    Col    Dia    Geb    Hag    Hus    Mul    Odi    Sel 
##   9.06  11.86 100.00  95.25   0.04  14.85   0.00  83.24  94.38  98.05 
##    Wis    Sav 
##  99.67  42.12
```

```r
barplot(sort(round(c * 100, 2)), main = "Taux de renseignement de l'item 'Motif de consultation'", 
    ylab = "pourcentage", xlab = "Services d'urgence")
```

![plot of chunk tous](figure/tous.png) 

Le motif de consultation nest pas renseigné dans 54.04 % des cas.

barplot(sort(round(c*100,2),decreasing=TRUE),main="Taux de renseignement de l'item 'Motif de consultation'",xlab="pourcentage",ylab="Services d'urgence",horiz=TRUE,las=2)

Altkirch
-----

```r
head(d1$MOTIF[d1$FINESS == "Alk"])
```

```
## [1] <NA> <NA> <NA> <NA> R600 <NA>
## 16734 Levels: ,, ... zona ; une pathologie ophtalmalogique au
```

```r
a <- is.na(d1$MOTIF[d1$FINESS == "Alk"])
b <- length(a[a == TRUE])
c <- b * 100/length(a)
print(c)
```

```
## [1] 88.14
```

L'item nest pas renseigné dans 88.1371 % des cas.

Wissembourg
-----

```r
head(d1$MOTIF[d1$FINESS == "Wis"])
```

```
## [1] T009 T119 T009 S008 R11  R11 
## 16734 Levels: ,, ... zona ; une pathologie ophtalmalogique au
```

```r
a <- is.na(d1$MOTIF[d1$FINESS == "Wis"])
b <- length(a[a == TRUE])
c <- b * 100/length(a)
print(c)
```

```
## [1] 0.3286
```

L'item nest pas renseigné dans 0.3286 % des cas.

Colmar
-----

```r
head(d1$MOTIF[d1$FINESS == "Col"])
```

```
## [1] une crise d'asthme                         
## [2] un malaise avec PC                         
## [3] Autre                                      
## [4] un traumatisme oculaire: explosion d'un    
## [5] plaie pied gauche par p\xe9tard ; une plaie
## [6] une br\xfblre                              
## 16734 Levels: ,, ... zona ; une pathologie ophtalmalogique au
```

```r
a <- is.na(d1$MOTIF[d1$FINESS == "Col"])
b <- length(a[a == TRUE])
c <- b * 100/length(a)
print(c)
```

```
## [1] 0
```

L'item nest pas renseigné dans 0 % des cas.

Mulhouse
--------

```r
head(d1$MOTIF[d1$FINESS == "Mul"])
```

```
## [1] S37.0 R05   R10.4 R41.0 R10.4 J45.9
## 16734 Levels: ,, ... zona ; une pathologie ophtalmalogique au
```

```r
a <- is.na(d1$MOTIF[d1$FINESS == "Mul"])
b <- length(a[a == TRUE])
c <- b * 100/length(a)
print(c)
```

```
## [1] 16.76
```

L'item nest pas renseigné dans 16.7559 % des cas.
