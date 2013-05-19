RPU 2013 Analyse
========================================================

```r
date()
```

```
## [1] "Sun May 19 17:54:09 2013"
```

source: RPU2013
Ce document exploite le fichier RData préparé à partir de la table *RPU__* de Sagec. Voir le document *RPU_2013_Preparation.Rmd* du dossier Resural.

Librairies nécessaires:
-----------------------

```r
library("gdata")
library("rgrs")
library("lubridate")
library("rattle")
library("epicalc")
library("zoo")
library("xts")
```

Chargement des routines perso
-----------------------------

```r
source("mes_fonctions.R")
```

```
## Warning: impossible d'ouvrir le fichier 'mes_fonctions.R' : Aucun fichier
## ou dossier de ce type
```

```
## Error: impossible d'ouvrir la connexion
```


Lecture du fichier des données
---------------------------------------
On lit le fichier de travail créé:

```r
load("rpu2013.Rda")
attach(d1)
```

Les données sont enregistrées dans un data.frame appelé *d1*.

Analyse des données
===================

```r
n <- dim(d1)
print(n)
```

```
## [1] 105979     20
```

```r
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
str(d1)
```

```
## 'data.frame':	105979 obs. of  20 variables:
##  $ id           : chr  "2c9d83843bf5e01d013bf5e985d20225" "2c9d83843bf5e01d013bf5e986950226" "2c9d83843bf5e01d013bf5e987620227" "2c9d83843bf5e01d013bf5e988060228" ...
##  $ CODE_POSTAL  : Factor w/ 1277 levels "00000","00159",..: 706 706 706 706 706 701 818 706 706 706 ...
##  $ COMMUNE      : Factor w/ 2691 levels "00","01257 DRESDEN ALLEMAGNE",..: 2184 2184 2184 2184 741 2048 2033 2184 2184 2184 ...
##  $ DESTINATION  : Factor w/ 7 levels "NA","MCO","SSR",..: NA NA NA NA NA NA 2 NA 2 NA ...
##  $ DP           : chr  "R104" "J038" "S617" "M485" ...
##  $ ENTREE       : chr  "2013-01-01 00:04:00" "2013-01-01 00:16:00" "2013-01-01 00:26:00" "2013-01-01 00:32:00" ...
##  $ EXTRACT      : chr  "2013-01-01 05:37:00" "2013-01-01 05:37:00" "2013-01-01 05:37:00" "2013-01-01 05:37:00" ...
##  $ FINESS       : Factor w/ 11 levels "3Fr","Alk","Col",..: 10 10 10 10 10 10 10 10 10 10 ...
##  $ GRAVITE      : Factor w/ 7 levels "1","2","3","4",..: 2 2 3 2 2 1 3 2 2 2 ...
##  $ MODE_ENTREE  : Factor w/ 4 levels "NA","Mutation",..: 4 4 4 4 4 4 4 4 4 4 ...
##  $ MODE_SORTIE  : Factor w/ 5 levels "NA","Mutation",..: 4 4 4 4 4 4 2 4 2 4 ...
##  $ MOTIF        : chr  "GASTRO04" "DIVERS23" "TRAUMATO10" "TRAUMATO02" ...
##  $ NAISSANCE    : chr  "1960-04-08 00:00:00" "1986-03-05 00:00:00" "1971-12-22 00:00:00" "1927-04-27 00:00:00" ...
##  $ ORIENTATION  : Factor w/ 13 levels "CHIR","FUGUE",..: NA NA NA NA NA NA 5 NA 5 NA ...
##  $ PROVENANCE   : Factor w/ 7 levels "NA","MCO","SSR",..: 6 6 6 6 6 6 6 6 6 6 ...
##  $ SEXE         : Factor w/ 3 levels "F","I","M": 3 3 3 1 3 3 1 1 1 1 ...
##  $ SORTIE       : chr  "2013-01-01 02:38:00" "2013-01-01 00:38:00" "2013-01-01 02:07:00" "2013-01-01 01:52:00" ...
##  $ TRANSPORT    : Factor w/ 6 levels "AMBU","FO","HELI",..: 4 4 4 1 4 4 6 6 4 4 ...
##  $ TRANSPORT_PEC: Factor w/ 3 levels "AUCUN","MED",..: 1 1 1 3 1 1 2 2 1 1 ...
##  $ AGE          : num  52 26 41 85 39 9 79 50 46 18 ...
```

```r
summary(d1)
```

```
##       id             CODE_POSTAL           COMMUNE       DESTINATION   
##  Length:105979      68000  : 7771   MULHOUSE   :12389   MCO    :23062  
##  Class :character   68200  : 6557   STRASBOURG :11504   PSY    :  399  
##  Mode  :character   68100  : 5866   COLMAR     : 7768   SSR    :   17  
##                     67100  : 5129   HAGUENAU   : 2267   HMS    :    8  
##                     67000  : 3757   SELESTAT   : 2000   SLD    :    4  
##                     67600  : 3005   SAINT LOUIS: 1817   (Other):    0  
##                     (Other):73894   (Other)    :68234   NA's   :82489  
##       DP               ENTREE            EXTRACT              FINESS     
##  Length:105979      Length:105979      Length:105979      Col    :21841  
##  Class :character   Class :character   Class :character   Mul    :16790  
##  Mode  :character   Mode  :character   Mode  :character   Hus    :13095  
##                                                           Hag    :11627  
##                                                           Sel    : 9685  
##                                                           Dia    : 9605  
##                                                           (Other):23336  
##     GRAVITE         MODE_ENTREE       MODE_SORTIE       MOTIF          
##  2      :64451   NA       :    0   NA       :    0   Length:105979     
##  3      :12856   Mutation : 1282   Mutation :21950   Class :character  
##  1      :12797   Transfert: 1128   Transfert: 1523   Mode  :character  
##  4      : 1320   Domicile :91250   Domicile :66755                     
##  P      :  480   NA's     :12319   Décès    :    0                     
##  (Other):  284                     NA's     :15751                     
##  NA's   :13791                                                         
##   NAISSANCE          ORIENTATION      PROVENANCE    SEXE     
##  Length:105979      UHCD   :11496   PEA    :59352   F:50853  
##  Class :character   MED    : 5662   PEO    : 9254   I:    1  
##  Mode  :character   CHIR   : 2342   MCO    : 2574   M:55125  
##                     PSA    :  954   SSR    :   11            
##                     SI     :  445   PSY    :   11            
##                     (Other): 1481   (Other):    9            
##                     NA's   :83599   NA's   :34768            
##     SORTIE          TRANSPORT     TRANSPORT_PEC        AGE     
##  Length:105979      AMBU :16290   AUCUN  :75794   Min.   :  0  
##  Class :character   FO   :  508   MED    : 2120   1st Qu.: 18  
##  Mode  :character   HELI :   37   PARAMED: 2430   Median : 39  
##                     PERSO:58281   NA's   :25635   Mean   : 41  
##                     SMUR : 1027                   3rd Qu.: 63  
##                     VSAB : 9263                   Max.   :112  
##                     NA's :20573                   NA's   :5
```

Stuctures hospitaliéres participantes
=====================================
- *Alk* CH d' Alkirch
- *Col* CH Colmar (Pasteur + Parc)
- *Dia* Diaconat-Fonderie
- *2Fr* Clinique des trois frontières
- *Geb* CH de Guebwiller
- *Hag* CH de Haguenau
- *Hus* Hôpiaux Universitaires de Strasbourg
- *Mul* CH de Mulhouse
- *Odi* Clinique Ste Odile
- *Sel* CH de Sélestat
- *Wis* CH de Wissembourg
Hôpitaux ne transmettant pas de données:
- *Sav* CH de Saverne
- *Tha* CH de Thann
- *Ann* Clinique Ste Anne

```r
summary(d1$FINESS)
```

```
##   3Fr   Alk   Col   Dia   Geb   Hag   Hus   Mul   Odi   Sel   Wis 
##  5212   891 21841  9605  4807 11627 13095 16790  8415  9685  4011
```

```r
a <- table(d1$FINESS)
round(prop.table(a) * 100, digits = 2)
```

```
## 
##   3Fr   Alk   Col   Dia   Geb   Hag   Hus   Mul   Odi   Sel   Wis 
##  4.92  0.84 20.61  9.06  4.54 10.97 12.36 15.84  7.94  9.14  3.78
```

Projection sur l'année:

```r
summary(d1$FINESS) * 3
```

```
##   3Fr   Alk   Col   Dia   Geb   Hag   Hus   Mul   Odi   Sel   Wis 
## 15636  2673 65523 28815 14421 34881 39285 50370 25245 29055 12033
```

```r
sum(summary(d1$FINESS) * 3)
```

```
## [1] 317937
```

```r

t1 <- table(d1$FINESS)
t2 <- table(d1$FINESS) * 3
t3 <- rbind(t1, t2)
rownames(t3) <- c("1er Quadrimestre", "Projection 2013")
xtable(t(t3))
```

```
## Error: impossible de trouver la fonction "xtable"
```

### Origine temporelle des données:

```r
b <- tapply(as.Date(d1$ENTREE), d1$FINESS, min)
c <- as.Date(b, origin = "1970-01-01")
cbind(as.character(sort(c)))
```

```
##     [,1]        
## 3Fr "2013-01-01"
## Col "2013-01-01"
## Dia "2013-01-01"
## Geb "2013-01-01"
## Hag "2013-01-01"
## Hus "2013-01-01"
## Odi "2013-01-01"
## Sel "2013-01-01"
## Wis "2013-01-01"
## Mul "2013-01-07"
## Alk "2013-04-01"
```

Exhaustivité des données
------------------------
Il faut tranformer les valeurs NULL en NA pour pouvoir les comptabiliser. Les valeurs NULL apparaissent pour les factors: DP, MOTIF, TRANSPORT, ORIENTATION,GRAVITE, SORTIE. Il faut les transformer en charecter pour leur attriber la valeur NA au lieu de NULL:

```r
a <- as.character(d1$DP)
a[a == "NULL"] <- NA
sum(is.na(a))
```

```
## [1] 32760
```

```r
mean(is.na(a))
```

```
## [1] 0.3091
```

sum(is.na(a)) retourne le nombre de lignes concernées et *mean(is.na(a))* donne directement le pourcentage de valeurs nulles (R in action pp 356)

```r
d1$DP <- a

a <- as.character(d1$MOTIF)
a[a == "NULL"] <- NA
d1$MOTIF <- a

a <- as.character(d1$TRANSPORT)
a[a == "NULL"] <- NA
d1$TRANSPORT <- a

a <- as.character(d1$ORIENTATION)
a[a == "NULL"] <- NA
d1$ORIENTATION <- a

a <- as.character(d1$GRAVITE)
a[a == "NULL"] <- NA
d1$GRAVITE <- a

a <- as.character(d1$SORTIE)
a[a == "NULL"] <- NA
d1$SORTIE <- a

a <- as.character(d1$ENTREE)
a[a == "NULL"] <- NA
d1$ENTREE <- a
```

Les 2 lignes qui suivent comptent les NA

```r
a <- is.na(d1)
b <- apply(a, 2, mean)
a <- cbind(sort(round(b * 100, 2)))
colnames(a) <- "%"
a
```

```
##                   %
## id             0.00
## CODE_POSTAL    0.00
## COMMUNE        0.00
## ENTREE         0.00
## EXTRACT        0.00
## FINESS         0.00
## NAISSANCE      0.00
## SEXE           0.00
## AGE            0.00
## SORTIE         9.02
## MODE_ENTREE   11.62
## GRAVITE       13.01
## MODE_SORTIE   14.86
## TRANSPORT     19.41
## TRANSPORT_PEC 24.19
## DP            30.91
## PROVENANCE    32.81
## MOTIF         34.87
## DESTINATION   77.84
## ORIENTATION   78.88
```

MODE_SORTIE (hospitalisation ou retour à domicile): dans 14.86% des cas on ne sait pas ce que devient le patient. Pour sélectionner les hospitalisés et éliminer les NA et les valeurs nulles:

```r
a <- d1$MODE_SORTIE[MODE_SORTIE == "Mutation" | MODE_SORTIE == "Transfert"]
a <- na.omit(a)
a <- as.factor(as.character(a))
summary(a)
```

```
##  Mutation Transfert 
##     21950      1523
```

```r
round(prop.table(table(a)) * 100, 2)
```

```
## a
##  Mutation Transfert 
##     93.51      6.49
```

```r

a <- d1[MODE_SORTIE == "Mutation" | MODE_SORTIE == "Transfert", ]
a <- na.omit(a)
summary(a$DESTINATION)
```

```
##   NA  MCO  SSR  SLD  PSY  HAD  HMS 
##    0 8259    2    1  128    0    0
```

```r
summary(as.factor(a$ORIENTATION))
```

```
## CHIR  HDT   HO  MED OBST  REA   SC   SI UHCD 
## 1718   14    9 3969   21  216  299  308 1836
```

```r
round(prop.table(table(as.factor(a$ORIENTATION))) * 100, 2)
```

```
## 
##  CHIR   HDT    HO   MED  OBST   REA    SC    SI  UHCD 
## 20.48  0.17  0.11 47.31  0.25  2.57  3.56  3.67 21.88
```

```r

tab1(as.factor(a$ORIENTATION), sort.group = "decreasing", horiz = TRUE, cex.names = 0.8, 
    xlab = "", main = "Orientation des patients hospitalisés")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-71.png) 

```
## as.factor(a$ORIENTATION) :  
##         Frequency Percent Cum. percent
## MED          3969    47.3         47.3
## UHCD         1836    21.9         69.2
## CHIR         1718    20.5         89.7
## SI            308     3.7         93.3
## SC            299     3.6         96.9
## REA           216     2.6         99.5
## OBST           21     0.3         99.7
## HDT            14     0.2         99.9
## HO              9     0.1        100.0
##   Total      8390   100.0        100.0
```

```r

a <- d1[MODE_SORTIE == "Domicile", ]
summary(as.factor(a$ORIENTATION))
```

```
##  CHIR FUGUE   HDT   MED   PSA   REA   REO  SCAM    SI  UHCD  NA's 
##    45    72     4    24   933     2   413   150     9    71 80783
```

```r
t <- table(as.factor(a$ORIENTATION))
round(prop.table(t) * 100, 2)
```

```
## 
##  CHIR FUGUE   HDT   MED   PSA   REA   REO  SCAM    SI  UHCD 
##  2.61  4.18  0.23  1.39 54.15  0.12 23.97  8.71  0.52  4.12
```

```r
tab1(as.factor(a$ORIENTATION), sort.group = "decreasing", horiz = TRUE, cex.names = 0.8, 
    xlab = "", main = "Orientation des patients non hospitalisés")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-72.png) 

```
## as.factor(a$ORIENTATION) :  
##         Frequency   %(NA+)   %(NA-)
## NA's        80783     97.9      0.0
## PSA           933      1.1     54.1
## REO           413      0.5     24.0
## SCAM          150      0.2      8.7
## FUGUE          72      0.1      4.2
## UHCD           71      0.1      4.1
## CHIR           45      0.1      2.6
## MED            24      0.0      1.4
## SI              9      0.0      0.5
## HDT             4      0.0      0.2
## REA             2      0.0      0.1
##   Total     82506    100.0    100.0
```

La table ci-dessus liste le devenir des patients non hospitalisés. On note des incohérences: REA, HDT, SI, Med, CHIR, UHCD. La ligne *Missing* correspond aux patients rentrés sur avis médical.

Adultes
-------
Répartition de la population adulte (18 ans et plus)

```r
a <- d1[AGE > 17, c("AGE", "FINESS")]
boxplot(a$AGE ~ a$FINESS, main = "Patients de 18 as et plus", col = "slategray1")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


Mineurs
-------

```r
a <- d1$AGE[d1$AGE <= 18]
# a
summary(a)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    0.00    2.00    7.00    7.77   13.00   18.00       5
```

```r
hist(a, main = "Moins de 18 ans", xlab = "Age (années)", col = "yellow")
```

![plot of chunk mineurs](figure/mineurs.png) 

```r

a <- d1$AGE[FINESS == "Col" & d1$AGE < 18]
# a
a <- d1$AGE[FINESS == "Hag" & d1$AGE < 18]
# a
a <- d1$AGE[FINESS == "Mul" & d1$AGE < 18]
# a
table(FINESS)
```

```
## FINESS
##   3Fr   Alk   Col   Dia   Geb   Hag   Hus   Mul   Odi   Sel   Wis 
##  5212   891 21841  9605  4807 11627 13095 16790  8415  9685  4011
```

Durée d'attente
===============
On utilise les données de Sélestat comme étude pilote:

```r
sel <- d1[d1$FINESS == "Sel", ]
e <- ymd_hms(sel$ENTREE)
s <- ymd_hms(sel$SORTIE)
q <- s - e
sel$attente <- q
summary(as.numeric(q))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##       1      85     137     162     217     841     237
```

Attente cumulée par jour (pour chaque jour, on cumule les durées d'attente):

```r
q <- tapply(sel$attente, as.Date(sel$ENTREE), sum, na.rm = TRUE)
summary(q)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     392   10500   12800   12700   14900   22500
```

```r
hist(q, main = "Attente cumulée par 24h", xlab = "Durée de passage (en mn)", 
    ylab = "Fréquence")
```

![plot of chunk attente](figure/attente1.png) 

```r

z <- zoo(q, unique(as.Date(sel$ENTREE)))
plot(z, main = "Attente cumulée par 24h", xlab = "Sélestat 2013")
```

![plot of chunk attente](figure/attente2.png) 

```r
plot(xts(z))
```

![plot of chunk attente](figure/attente3.png) 

```r
plot(rollmean(z, 7), main = "Attente cumulée par 24h (moyenne lissée)")
```

![plot of chunk attente](figure/attente4.png) 

```r
plot(rollmean(xts(z), 7))
```

![plot of chunk attente](figure/attente5.png) 


