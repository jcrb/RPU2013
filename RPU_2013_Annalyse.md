RPU 2013 Analyse
========================================================

```r
date()
```

```
## [1] "Sat Aug  3 11:44:42 2013"
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
library("xtable")
library("plotrix")
library("openintro")
```

Chargement des routines perso
-----------------------------

```r
source("../mes_fonctions.R")
```


Lecture du fichier des données
---------------------------------------
On lit le fichier de travail créé:

```r
# load('rpu2013.Rda')
load("rpu2013d0106.Rda")
save(d0106, file = "rpu2013d0106.Rda")
```

```
## Error: objet 'd0106' introuvable
```

```r
d1 <- d0105
rm(d0105)

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
## [1] 163915     20
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
## 'data.frame':	163915 obs. of  20 variables:
##  $ id           : chr  "2c9d83843bf5e01d013bf5e985d20225" "2c9d83843bf5e01d013bf5e986950226" "2c9d83843bf5e01d013bf5e987620227" "2c9d83843bf5e01d013bf5e988060228" ...
##  $ CODE_POSTAL  : Factor w/ 1755 levels "00000","00159",..: 706 706 706 706 706 701 818 706 706 706 ...
##  $ COMMUNE      : Factor w/ 3636 levels "00","01257 DRESDEN ALLEMAGNE",..: 2184 2184 2184 2184 741 2048 2033 2184 2184 2184 ...
##  $ DESTINATION  : Factor w/ 7 levels "NA","MCO","SSR",..: NA NA NA NA NA NA 2 NA 2 NA ...
##  $ DP           : chr  "R104" "J038" "S617" "M485" ...
##  $ ENTREE       : chr  "2013-01-01 00:04:00" "2013-01-01 00:16:00" "2013-01-01 00:26:00" "2013-01-01 00:32:00" ...
##  $ EXTRACT      : chr  "2013-01-01 05:37:00" "2013-01-01 05:37:00" "2013-01-01 05:37:00" "2013-01-01 05:37:00" ...
##  $ FINESS       : Factor w/ 12 levels "3Fr","Alk","Col",..: 10 10 10 10 10 10 10 10 10 10 ...
##  $ GRAVITE      : Factor w/ 7 levels "1","2","3","4",..: 2 2 3 2 2 1 3 2 2 2 ...
##  $ MODE_ENTREE  : Factor w/ 5 levels "NA","Mutation",..: 4 4 4 4 4 4 4 4 4 4 ...
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
##       id             CODE_POSTAL           COMMUNE        DESTINATION    
##  Length:163915      68000  : 11646   MULHOUSE  : 19333   MCO    : 34451  
##  Class :character   68200  : 10226   STRASBOURG: 17272   PSY    :   596  
##  Mode  :character   68100  :  9157   COLMAR    : 11640   SSR    :    27  
##                     67100  :  7854   HAGUENAU  :  3428   HMS    :    16  
##                     67000  :  5557   SELESTAT  :  3118   SLD    :     8  
##                     67600  :  4669   (Other)   :109121   (Other):     1  
##                     (Other):114806   NA's      :     3   NA's   :128816  
##       DP               ENTREE            EXTRACT              FINESS     
##  Length:163915      Length:163915      Length:163915      Col    :33153  
##  Class :character   Class :character   Class :character   Mul    :26911  
##  Mode  :character   Mode  :character   Mode  :character   Hag    :17533  
##                                                           Hus    :16298  
##                                                           Sel    :14920  
##                                                           Dia    :14695  
##                                                           (Other):40405  
##     GRAVITE           MODE_ENTREE        MODE_SORTIE    
##  2      :99923   NA         :     0   NA       :     0  
##  1      :19879   Mutation   :  1857   Mutation : 32774  
##  3      :19174   Transfert  :  1397   Transfert:  2345  
##  4      : 1827   Domicile   :141569   Domicile :103757  
##  P      :  723   Transfe  rt:   294   Décès    :     2  
##  (Other):  448   NA's       : 18798   NA's     : 25037  
##  NA's   :21941                                          
##     MOTIF            NAISSANCE          ORIENTATION       PROVENANCE   
##  Length:163915      Length:163915      UHCD   : 16706   PEA    :92063  
##  Class :character   Class :character   MED    :  8409   PEO    :14406  
##  Mode  :character   Mode  :character   CHIR   :  3616   MCO    : 3767  
##                                        PSA    :  1532   SSR    :   18  
##                                        SI     :   683   PSY    :   13  
##                                        (Other):  2288   (Other):   12  
##                                        NA's   :130681   NA's   :53636  
##  SEXE         SORTIE          TRANSPORT     TRANSPORT_PEC   
##  F:77894   Length:163915      AMBU :23396   AUCUN  :117035  
##  I:    2   Class :character   FO   :  730   MED    :  3273  
##  M:86019   Mode  :character   HELI :   77   PARAMED:  3574  
##                               PERSO:91821   NA's   : 40033  
##                               SMUR : 1452                   
##                               VSAB :14308                   
##                               NA's :32131                   
##       AGE       
##  Min.   :  0.0  
##  1st Qu.: 18.0  
##  Median : 38.0  
##  Mean   : 40.4  
##  3rd Qu.: 62.0  
##  Max.   :112.0  
##  NA's   :6
```

Stuctures hospitaliéres participantes
=====================================
- *Alk* CH d' Alkirch
- *Col* CH Colmar (Pasteur + Parc)
- *Dia* Diaconat-Fonderie
- *3Fr* Clinique des trois frontières
- *Geb* HUS
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
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##      7998      2759     33153     14695      7369     17533     16298 
##       Mul       Odi       Sel       Wis 670780055 
##     26911     12957     14920      6270      3052
```

```r
a <- table(d1$FINESS)
round(prop.table(a) * 100, digits = 2)
```

```
## 
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##      4.88      1.68     20.23      8.97      4.50     10.70      9.94 
##       Mul       Odi       Sel       Wis 670780055 
##     16.42      7.90      9.10      3.83      1.86
```

Passages déclarés au serveur régional:

   ALK  | COL  | CTF |  DIA |  GEB |  HUS |  MUL |  ODI |  SAV |  SEL  | TAN |  WIS 
   ----|-------|-----|------|------|------|-------|------|-----|-------|-----|-----
  4577 |21353 | 5475 | 3136  |4926 |41561 |20160 | 8417 | 8961 | 9670 | 4840 | 3052
  
  First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

Projection sur l'année:

```r
summary(d1$FINESS) * 3
```

```
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##     23994      8277     99459     44085     22107     52599     48894 
##       Mul       Odi       Sel       Wis 670780055 
##     80733     38871     44760     18810      9156
```

```r
sum(summary(d1$FINESS) * 3)
```

```
## [1] 491745
```

```r

t1 <- table(d1$FINESS)
t2 <- table(d1$FINESS) * 3
t3 <- rbind(t1, t2)
rownames(t3) <- c("1er Quadrimestre", "Projection 2013")
xtable(t(t3))
```

```
## % latex table generated in R 2.15.1 by xtable 1.7-1 package
## % Sat Aug  3 11:44:50 2013
## \begin{table}[ht]
## \centering
## \begin{tabular}{rrr}
##   \hline
##  & 1er Quadrimestre & Projection 2013 \\ 
##   \hline
## 3Fr & 7998.00 & 23994.00 \\ 
##   Alk & 2759.00 & 8277.00 \\ 
##   Col & 33153.00 & 99459.00 \\ 
##   Dia & 14695.00 & 44085.00 \\ 
##   Geb & 7369.00 & 22107.00 \\ 
##   Hag & 17533.00 & 52599.00 \\ 
##   Hus & 16298.00 & 48894.00 \\ 
##   Mul & 26911.00 & 80733.00 \\ 
##   Odi & 12957.00 & 38871.00 \\ 
##   Sel & 14920.00 & 44760.00 \\ 
##   Wis & 6270.00 & 18810.00 \\ 
##   670780055 & 3052.00 & 9156.00 \\ 
##    \hline
## \end{tabular}
## \end{table}
```

### Origine temporelle des données:

```r
b <- tapply(as.Date(d1$ENTREE), d1$FINESS, min)
c <- as.Date(b, origin = "1970-01-01")
cbind(as.character(sort(c)))
```

```
##           [,1]        
## 3Fr       "2013-01-01"
## Col       "2013-01-01"
## Dia       "2013-01-01"
## Geb       "2013-01-01"
## Hag       "2013-01-01"
## Hus       "2013-01-01"
## Odi       "2013-01-01"
## Sel       "2013-01-01"
## Wis       "2013-01-01"
## Mul       "2013-01-07"
## Alk       "2013-04-01"
## 670780055 "2013-06-01"
```

Exhaustivité des données
------------------------
Il faut tranformer les valeurs NULL en NA pour pouvoir les comptabiliser. Les valeurs NULL apparaissent pour les factors: DP, MOTIF, TRANSPORT, ORIENTATION,GRAVITE, SORTIE. Il faut les transformer en character pour leur attriber la valeur NA au lieu de NULL:

```r
a <- as.character(d1$DP)
a[a == "NULL"] <- NA
sum(is.na(a))
```

```
## [1] 50718
```

```r
mean(is.na(a))
```

```
## [1] 0.3094
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
## SORTIE         9.23
## MODE_ENTREE   11.47
## GRAVITE       13.39
## MODE_SORTIE   15.27
## TRANSPORT     19.60
## TRANSPORT_PEC 24.42
## DP            30.94
## PROVENANCE    32.72
## MOTIF         35.09
## DESTINATION   78.59
## ORIENTATION   79.72
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
##     32774      2345
```

```r
round(prop.table(table(a)) * 100, 2)
```

```
## a
##  Mutation Transfert 
##     93.32      6.68
```

```r

a <- d1[MODE_SORTIE == "Mutation" | MODE_SORTIE == "Transfert", ]
a <- na.omit(a)
summary(a$DESTINATION)
```

```
##    NA   MCO   SSR   SLD   PSY   HAD   HMS 
##     0 12544     2     3   204     0     0
```

```r
summary(as.factor(a$ORIENTATION))
```

```
## CHIR  HDT   HO  MED OBST  REA   SC   SI UHCD 
## 2659   29   12 6023   27  344  472  467 2720
```

```r
round(prop.table(table(as.factor(a$ORIENTATION))) * 100, 2)
```

```
## 
##  CHIR   HDT    HO   MED  OBST   REA    SC    SI  UHCD 
## 20.85  0.23  0.09 47.23  0.21  2.70  3.70  3.66 21.33
```

```r

tab1(as.factor(a$ORIENTATION), sort.group = "decreasing", horiz = TRUE, cex.names = 0.8, 
    xlab = "", main = "Orientation des patients hospitalisés")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-71.png) 

```
## as.factor(a$ORIENTATION) :  
##         Frequency Percent Cum. percent
## MED          6023    47.2         47.2
## UHCD         2720    21.3         68.6
## CHIR         2659    20.8         89.4
## SC            472     3.7         93.1
## SI            467     3.7         96.8
## REA           344     2.7         99.5
## HDT            29     0.2         99.7
## OBST           27     0.2         99.9
## HO             12     0.1        100.0
##   Total     12753   100.0        100.0
```

```r

a <- d1[MODE_SORTIE == "Domicile", ]
summary(as.factor(a$ORIENTATION))
```

```
##   CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO     SC 
##     66    113      7      1     38      1   1501      4    646      1 
##   SCAM     SI   UHCD   NA's 
##    232     16    110 126058
```

```r
t <- table(as.factor(a$ORIENTATION))
round(prop.table(t) * 100, 2)
```

```
## 
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##  2.41  4.13  0.26  0.04  1.39  0.04 54.86  0.15 23.61  0.04  8.48  0.58 
##  UHCD 
##  4.02
```

```r
tab1(as.factor(a$ORIENTATION), sort.group = "decreasing", horiz = TRUE, cex.names = 0.8, 
    xlab = "", main = "Orientation des patients non hospitalisés")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-72.png) 

```
## as.factor(a$ORIENTATION) :  
##         Frequency   %(NA+)   %(NA-)
## NA's       126058     97.9      0.0
## PSA          1501      1.2     54.9
## REO           646      0.5     23.6
## SCAM          232      0.2      8.5
## FUGUE         113      0.1      4.1
## UHCD          110      0.1      4.0
## CHIR           66      0.1      2.4
## MED            38      0.0      1.4
## SI             16      0.0      0.6
## HDT             7      0.0      0.3
## REA             4      0.0      0.1
## HO              1      0.0      0.0
## OBST            1      0.0      0.0
## SC              1      0.0      0.0
##   Total    128794    100.0    100.0
```

La table ci-dessus liste le devenir des patients non hospitalisés. On note des incohérences: REA, HDT, SI, Med, CHIR, UHCD. La ligne *Missing* correspond aux patients rentrés sur avis médical.

Etude des patients hospitalisés
--------------------------------
La rubrique mode de sortie peut se décomposer en 3 éléments
- *hosp*: patient hospitalisés, cad gardé en milieu de soins par *MUTATION* ou *TRANSFERT*
- *dom*: retour à domicile ou équivalent
- *dcd*: patients décédés aux urgences
Dans l'échantillon *d1* c'est la colonne *MODE_SORTIE* qui renseigne sur le devenir du patient à la sortie des urgences:


```
## [1] "d1 compte  163915  lignes"
```

Il y a deux façons de former des sous ensembles avec R:
- sélectionner en utilisant la notation vectorielle: hosp<-d1[d1$MODE_SORTIE=="Mutation" | d1$MODE_SORTIE=="Transfert",]
- sélectionner avec la méthode **subset**: b<-subset(d1,MODE_SORTIE=="Mutation" | MODE_SORTIE=="Transfert")

La première méthode sélectionne toutes les lignes correspondant aux critères ET celles où le critère vaut *NA*. ie, la méthode 1 retourne un data frame de 39224 lignes et 20 colonnes.

La méthode *subset* ne tient pas compte des lignes où le critère vaut NA. Dans l'exemple, retourne un dataframe de 23473 lignes et 20 colonnes.


```r
hosp <- d1[d1$MODE_SORTIE == "Mutation" | d1$MODE_SORTIE == "Transfert", ]
dom <- d1[d1$MODE_SORTIE == "Domicile", ]
dcd <- d1[d1$MODE_SORTIE == "Deces", ]
nbna <- nrow(hosp) + nrow(dom) + nrow(dcd) - nrow(d1)
pna <- round(nbna * 100/nrow(d1), 2)

print(paste("hosp = ", nrow(hosp), " lignes"))
```

```
## [1] "hosp =  60156  lignes"
```

```r
print(paste("dom = ", nrow(dom), " lignes"))
```

```
## [1] "dom =  128794  lignes"
```

```r
print(paste("dcd = ", nrow(dcd), " lignes"))
```

```
## [1] "dcd =  25037  lignes"
```

```r

print(paste("La différence du nombre de lignes entre d1 et hosp, dom et dcd indique le nmbre de lignes correspondant à NA et qui sont incluses dans le décompte des lignes de chaque sous ensemble: ", 
    nbna, "correspondant aux mode de sortie non renseignés soit ", pna, " %"))
```

```
## [1] "La différence du nombre de lignes entre d1 et hosp, dom et dcd indique le nmbre de lignes correspondant à NA et qui sont incluses dans le décompte des lignes de chaque sous ensemble:  50072 correspondant aux mode de sortie non renseignés soit  30.55  %"
```

Avec *subset* on élimine ces lignes parasites:

```r
a <- subset(d1, MODE_SORTIE == "Domicile")
b <- subset(d1, MODE_SORTIE == "Mutation" | MODE_SORTIE == "Transfert")
nrow(a)
```

```
## [1] 103757
```

```r
nrow(b)
```

```
## [1] 35119
```

```r
nrow(d1) - nrow(a) - nrow(b)
```

```
## [1] 25039
```

```r

print("O")
```

```
## [1] "O"
```

```r
t <- table(b$ORIENTATION, b$FINESS, useNA = "ifany")
m1 <- margin.table(t, 1)
t2 <- cbind(t, m1)
m2 <- margin.table(t2, 2)
rbind(t2, m2)
```

```
##      3Fr Alk  Col  Dia Geb  Hag  Hus  Mul Odi  Sel  Wis 670780055    m1
## CHIR   0   0 1486   18   0  545    0  685  83  656    6         0  3479
## HDT    0   0   28    0   1    0    0    2   0    0    9         0    40
## HO     0   0    5    0   0    0    0    3   0    0    7         0    15
## MED    0   0 3359    4   0 1093  233 1267  26 2221   14        38  8255
## OBST   0   0   18    0   0   23    0    0   1    9    0         0    51
## PSA    0   1    0    4   0    0    0    0   0    0    0         0     5
## REA    0   0  186    1   0   82    0  125   0   49    3         0   446
## REO    3   4    0    5   0    0    0    0   1    0    0         0    13
## SC     0   0  219    0   0   41    0  366   0    1   14         0   641
## SI     0   0  321    0   0  147    0  145   5    4    9         0   631
## UHCD   0   0 2451    3   0 2154 8664  338   0  200   17      1604 15431
## <NA> 173 450  231 1347   6 1035    0  968 510    0 1392         0  6112
## m2   176 455 8304 1382   7 5120 8897 3899 626 3140 1471      1642 35119
```

```r

summary(a$MODE_SORTIE)
```

```
##        NA  Mutation Transfert  Domicile     Décès 
##         0         0         0    103757         0
```

```r
summary(b$MODE_SORTIE)
```

```
##        NA  Mutation Transfert  Domicile     Décès 
##         0     32774      2345         0         0
```

- nb total de lignes = 105979
- total hospitalisés = 21950 +  1523
- total non hospitalisés = 66755 
- non réponses = 105979-90228 = 15751

```r
summary(b$DESTINATION)
```

```
##    NA   MCO   SSR   SLD   PSY   HAD   HMS  NA's 
##     0 34318    27     8   590     0     0   176
```

```r
summary(b$ORIENTATION)
```

```
##    Length     Class      Mode 
##     35119 character character
```

```r
summary(a$DESTINATION)
```

```
##     NA    MCO    SSR    SLD    PSY    HAD    HMS   NA's 
##      0    121      0      0      0      1     16 103619
```

```r
summary(a$ORIENTATION)
```

```
##    Length     Class      Mode 
##    103757 character character
```





on forme un dataframe *hosp* des patients hospitalisés par mutation ou transfert:

```r
hosp <- d1[d1$MODE_SORTIE == "Mutation" | d1$MODE_SORTIE == "Transfert", ]
summary(d1$MODE_SORTIE)
```

```
##        NA  Mutation Transfert  Domicile     Décès      NA's 
##         0     32774      2345    103757         2     25037
```

```r
prop.table(summary(d1$MODE_SORTIE)) * 100
```

```
##        NA  Mutation Transfert  Domicile     Décès      NA's 
##   0.00000  19.99451   1.43062  63.29927   0.00122  15.27438
```

#### Destinations

```r
summary(hosp$DESTINATION)
```

```
##    NA   MCO   SSR   SLD   PSY   HAD   HMS  NA's 
##     0 34318    27     8   590     0     0 25213
```

```r
prop.table(summary(hosp$DESTINATION))
```

```
##        NA       MCO       SSR       SLD       PSY       HAD       HMS 
## 0.0000000 0.5704834 0.0004488 0.0001330 0.0098078 0.0000000 0.0000000 
##      NA's 
## 0.4191269
```

```r
# sans les NA
table(hosp$DESTINATION)
```

```
## 
##    NA   MCO   SSR   SLD   PSY   HAD   HMS 
##     0 34318    27     8   590     0     0
```

```r
prop.table(table(hosp$DESTINATION)) * 100
```

```
## 
##       NA      MCO      SSR      SLD      PSY      HAD      HMS 
##  0.00000 98.21137  0.07727  0.02289  1.68846  0.00000  0.00000
```


#### Orientation des hospitalisés MCO (avec et sans les NA):

```r
a <- as.factor(hosp$ORIENTATION[hosp$DESTINATION == "MCO"])
a <- summary(a)
a
```

```
##  CHIR   HDT    HO   MED  OBST   PSA   REA   REO    SC    SI  UHCD  NA's 
##  3404     5     8  8120    51     5   440    13   636   631 15412 30806
```

```r
round(prop.table(a) * 100, 2)
```

```
##  CHIR   HDT    HO   MED  OBST   PSA   REA   REO    SC    SI  UHCD  NA's 
##  5.72  0.01  0.01 13.64  0.09  0.01  0.74  0.02  1.07  1.06 25.89 51.75
```

```r

a <- table(hosp$ORIENTATION[hosp$DESTINATION == "MCO"])
a
```

```
## 
##  CHIR   HDT    HO   MED  OBST   PSA   REA   REO    SC    SI  UHCD 
##  3404     5     8  8120    51     5   440    13   636   631 15412
```

```r
a <- prop.table(a) * 100
a
```

```
## 
##     CHIR      HDT       HO      MED     OBST      PSA      REA      REO 
## 11.85030  0.01741  0.02785 28.26806  0.17755  0.01741  1.53177  0.04526 
##       SC       SI     UHCD 
##  2.21410  2.19669 53.65361
```

```r
sce_chauds <- a["REA"] + a["SI"] + a["SC"]
print(paste("Services chauds: ", round(sce_chauds, 2), " %"))
```

```
## [1] "Services chauds:  5.94  %"
```

```r
mco <- a["CHIR"] + a["MED"] + a["OBST"]
print(paste("MCO: ", round(mco, 2), " %"))
```

```
## [1] "MCO:  40.3  %"
```

```r
print(paste("UHTCD: ", round(a["UHCD"], 2), " %"))
```

```
## [1] "UHTCD:  53.65  %"
```

```r
print(paste("Atypiques: ", round(a["FUGUE"] + a["PSA"] + a["SCAM"] + a["REO"], 
    2), " %"))
```

```
## [1] "Atypiques:  NA  %"
```

```r
print(paste("HDT-HO: ", round(a["HDT"] + a["HO"], 2), " %"))
```

```
## [1] "HDT-HO:  0.05  %"
```

Quelques erreurs de codage:
- Fugue, HDT, HO, PSA,REO, SCAM devraient être nuls
dom<-d1
#### Orientation des patients hospitalisés en Psychiatrie:

```r
a <- summary(hosp$ORIENTATION[hosp$DESTINATION == "PSY"])
a
```

```
##    Length     Class      Mode 
##     25803 character character
```

```r
a <- table(hosp$ORIENTATION[hosp$DESTINATION == "PSY"])
a
```

```
## 
## CHIR  HDT   HO  MED  REA   SC UHCD 
##   75   35    7  130    5    5    9
```

```r

a <- d1[d1$DESTINATION == "PSY", ]
a$DESTINATION <- as.character(a$DESTINATION)
a <- a[!is.na(a$DESTINATION), ]
summary(a$ORIENTATION)
```

```
##    Length     Class      Mode 
##       596 character character
```

```r
round(prop.table(summary(a$ORIENTATION)) * 100, 3)
```

```
## Error: 'type' (character) de l'argument incorrect
```

#### Analyse de l'ensemble de la rubrique **ORIENTATION**

```r
d1$ORIENTATION <- as.factor(d1$ORIENTATION)
a <- summary(d1$ORIENTATION)
a
```

```
##   CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO     SC 
##   3616    114     63     16   8409     52   1532    490    661    660 
##   SCAM     SI   UHCD   NA's 
##    232    683  16706 130681
```

```r
a <- round(prop.table(a) * 100, 4)

sce_chauds <- a["REA"] + a["SI"] + a["SC"]
print(paste("Services chauds: ", round(sce_chauds, 2), " %"))
```

```
## [1] "Services chauds:  1.12  %"
```

```r
mco <- a["CHIR"] + a["MED"] + a["OBST"]
print(paste("MCO: ", round(mco, 2), " %"))
```

```
## [1] "MCO:  7.37  %"
```

```r
uhcd <- a["UHCD"]
print(paste("UHTCD: ", round(uhcd, 2), " %"))
```

```
## [1] "UHTCD:  10.19  %"
```

```r
atypique <- a["FUGUE"] + a["PSA"] + a["SCAM"] + a["REO"]
print(paste("Atypiques: ", round(atypique, 2), " %"))
```

```
## [1] "Atypiques:  1.55  %"
```

```r
psy <- a["HDT"] + a["HO"]
print(paste("HDT-HO: ", round(psy, 2), " %"))
```

```
## [1] "HDT-HO:  0.05  %"
```

```r
nr <- a["NA's"]

als <- c(mco, uhcd, nr, atypique, sce_chauds, psy)
lor <- c(49.39, 19.12, 17.25, 8.92, 5.24, 0.07)

r <- rbind(als, lor)
barplot(r, las = 2, beside = T, legend = T, ylab = "% des RPU", xlab = "", sub = "(Ref. ORULOR 2011 p.50)", 
    names.arg = c("MCO", "UHCD", "NR", "Atypiques", "REA", "PSY"), main = "Orientation des patients hospitalisés", 
    cex.sub = 0.6)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 

en fonction de l'établissement (NOTE: utilisation de useNA="ifany"):

```r
# analyse brute
t <- table(d1$ORIENTATION, d1$FINESS)
t
```

```
##        
##          3Fr  Alk  Col  Dia  Geb  Hag  Hus  Mul  Odi  Sel  Wis 670780055
##   CHIR     3    0 1490   40    1  545    0  744  129  657    7         0
##   FUGUE    0    2   53    5    0   18    0    0   20    1   15         0
##   HDT      0    0   29    0    1    0    0   24    0    0    9         0
##   HO       0    0    5    0    0    0    0    3    0    0    8         0
##   MED      0    0 3370    7    2 1093  233 1379   41 2230   16        38
##   OBST     0    0   18    0    0   23    0    0    2    9    0         0
##   PSA      1   63  521  533    0  256    0   91   19    3   45         0
##   REA      0    0  186    2    0   82    0  167    1   49    3         0
##   REO     24    9  561   63    0    0    0    0    2    0    2         0
##   SC       0    0  219    0    0   41    0  380    0    1   19         0
##   SCAM     2    6   92    6    1   78    0    8   21    0   18         0
##   SI       0    0  321    2    0  147    0  179    6   18   10         0
##   UHCD     0    0 2453    6    0 2154 9142 1034    0  200   25      1692
```

```r
# analyse brute incluant les NA
t <- table(d1$ORIENTATION, d1$FINESS, useNA = "ifany")
t
```

```
##        
##           3Fr   Alk   Col   Dia   Geb   Hag   Hus   Mul   Odi   Sel   Wis
##   CHIR      3     0  1490    40     1   545     0   744   129   657     7
##   FUGUE     0     2    53     5     0    18     0     0    20     1    15
##   HDT       0     0    29     0     1     0     0    24     0     0     9
##   HO        0     0     5     0     0     0     0     3     0     0     8
##   MED       0     0  3370     7     2  1093   233  1379    41  2230    16
##   OBST      0     0    18     0     0    23     0     0     2     9     0
##   PSA       1    63   521   533     0   256     0    91    19     3    45
##   REA       0     0   186     2     0    82     0   167     1    49     3
##   REO      24     9   561    63     0     0     0     0     2     0     2
##   SC        0     0   219     0     0    41     0   380     0     1    19
##   SCAM      2     6    92     6     1    78     0     8    21     0    18
##   SI        0     0   321     2     0   147     0   179     6    18    10
##   UHCD      0     0  2453     6     0  2154  9142  1034     0   200    25
##   <NA>   7968  2679 23835 14031  7364 13096  6923 22902 12716 11752  6093
##        
##         670780055
##   CHIR          0
##   FUGUE         0
##   HDT           0
##   HO            0
##   MED          38
##   OBST          0
##   PSA           0
##   REA           0
##   REO           0
##   SC            0
##   SCAM          0
##   SI            0
##   UHCD       1692
##   <NA>       1322
```

```r
# cette analyse ne permet pas de séparer les vraies non réponses des
# retours à domicile
hosp <- d1[d1$MODE_SORTIE == "Mutation" | d1$MODE_SORTIE == "Transfert", ]
t <- table(hosp$ORIENTATION, hosp$FINESS, useNA = "ifany")
t
```

```
##        
##           3Fr   Alk   Col   Dia   Geb   Hag   Hus   Mul   Odi   Sel   Wis
##   CHIR      0     0  1486    18     0   545     0   685    83   656     6
##   FUGUE     0     0     0     0     0     0     0     0     0     0     0
##   HDT       0     0    28     0     1     0     0     2     0     0     9
##   HO        0     0     5     0     0     0     0     3     0     0     7
##   MED       0     0  3359     4     0  1093   233  1267    26  2221    14
##   OBST      0     0    18     0     0    23     0     0     1     9     0
##   PSA       0     1     0     4     0     0     0     0     0     0     0
##   REA       0     0   186     1     0    82     0   125     0    49     3
##   REO       3     4     0     5     0     0     0     0     1     0     0
##   SC        0     0   219     0     0    41     0   366     0     1    14
##   SCAM      0     0     0     0     0     0     0     0     0     0     0
##   SI        0     0   321     0     0   147     0   145     5     4     9
##   UHCD      0     0  2451     3     0  2154  8664   338     0   200    17
##   <NA>    173   450   231  1347     6  1035     0   968   510     0  1392
##        
##         670780055  <NA>
##   CHIR          0     0
##   FUGUE         0     0
##   HDT           0     0
##   HO            0     0
##   MED          38     0
##   OBST          0     0
##   PSA           0     0
##   REA           0     0
##   REO           0     0
##   SC            0     0
##   SCAM          0     0
##   SI            0     0
##   UHCD       1604     0
##   <NA>          0 25037
```

```r
# non hospitalisés
dom <- d1[d1$MODE_SORTIE == "Domicile", ]
```



Adultes
-------
Répartition de la population adulte (18 ans et plus)

```r
a <- d1[AGE > 17, c("AGE", "FINESS")]
boxplot(a$AGE ~ a$FINESS, main = "Patients de 18 ans et plus", col = "slategray1")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


Mineurs
-------

```r
a <- d1$AGE[d1$AGE <= 18]
# a
summary(a)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    0.00    2.00    7.00    7.92   13.00   18.00       6
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
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##      7998      2759     33153     14695      7369     17533     16298 
##       Mul       Odi       Sel       Wis 670780055 
##     26911     12957     14920      6270      3052
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
##       1      86     138     162     216     937     434
```

Attente cumulée par jour (pour chaque jour, on cumule les durées d'attente) en mn:

```r
q <- tapply(sel$attente, as.Date(sel$ENTREE), sum, na.rm = TRUE)
summary(q)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0   10800   13100   13100   15200   23000
```

```r
hist(q, main = "Attente cumulée par 24h", xlab = "Durée de passage (en mn)", 
    ylab = "Fréquence", col = "orange")
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
plot(rollmean(xts(z), 7), main = "Attente cumulée (lissée) par 24h", xlab = "Durée de passage (en mn)", 
    ylab = "Fréquence")
```

![plot of chunk attente](figure/attente5.png) 

Ensemble des SAU
----------------
attente en mn:

```r
e <- ymd_hms(d1$ENTREE)
s <- ymd_hms(d1$SORTIE)
q <- s - e
d1$passage <- q/60

tapply(d1$passage, d1$FINESS, mean, na.rm = TRUE)
```

```
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##    135.98    150.30    169.05    166.31     79.51    369.17     74.04 
##       Mul       Odi       Sel       Wis 670780055 
##    181.14     99.54    162.50    139.84     68.94
```

```r
tapply(d1$passage, d1$FINESS, sd, na.rm = TRUE)
```

```
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##     143.3     183.2     168.6     143.7     132.0     339.2     270.4 
##       Mul       Odi       Sel       Wis 670780055 
##     136.9     109.7     103.9     175.9     271.8
```

```r
tapply(d1$passage, d1$FINESS, median, na.rm = TRUE)
```

```
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##       111       105       119       139        51       255         1 
##       Mul       Odi       Sel       Wis 670780055 
##       146        80       138        92         1
```

```r
boxplot(as.numeric(d1$passage) ~ d1$FINESS, col = "pink")
```

![plot of chunk attente_sau](figure/attente_sau.png) 

attente de moins d'une journée:

```r
h24 <- d1[as.numeric(d1$passage) < 1000, c("passage", "FINESS")]
boxplot(as.numeric(h24$passage) ~ h24$FINESS, col = "pink", main = "Durée moyenne de passage (pour t<24h)", 
    ylab = "Temps en minutes", xlab = "SAU - 2013")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-101.png) 

```r
boxplot(as.numeric(h24$passage) ~ h24$FINESS, col = "yellow", range = 0, notch = TRUE, 
    border = "blue", main = "Durée moyenne de passage", ylab = "Temps en minutes", 
    xlab = "SAU - 2013")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-102.png) 

Maladies infectieuses
=====================
Codes CIM 10:
- bronchiolite: J11
- Grippe: J11, J10, J09
- Gastroenterite: A09

Regroupement | Code CIM 10 | Description
------------ | ------------ | -----------
Hyperthermies |T67 | Effets de la chaleur et de la lumière
Hyperthermies | X30 |Exposition à une chaleur naturelle excessive
Déshydratations |E86 |Hypovolémie
Hyponatrémies | E871 | Hypo-osmolarité et hyponatrémie
Malaises | R42 | Etourdissements et éblouissements
Malaises |R53| Malaise et fatigue
Malaises | R55| Syncope et collapsus
Asthme|J45 | Asthme
Asthme |J46 | Etat de mal asthmatique
Piqûres arthropodes ou autres |T63 |Effet toxique d’un contact avec un animal venimeux
Piqûres arthropodes ou autres |W57 |Morsure ou piqûre non venimeuse d’insectes et arthropodes
Piqûres arthropodes ou autres |X20→X29 | Contact avec des animaux ou des plantes venimeuses

Pendant toute la durée du Plan Canicule, du 1er juin au 31 août.


on veut mettre 3 graphiques sur le même dessin

```r
par(mfrow = c(3, 1))
```


gastro
------

```r
gastro <- d1[substr(d1$DP, 1, 3) == "A09", c("DP", "ENTREE")]
g <- gastro[complete.cases(gastro), ]
g$date <- as.Date(g$ENTREE)
hist(g$date, breaks = 18, freq = TRUE, col = "slategray1", main = "2013 - Gastroentérites", 
    xlab = "")
```

![plot of chunk gastro](figure/gastro1.png) 

```r
g$date2 <- ymd_hms(g$ENTREE)
wg <- week(g$date2)
barplot(summary(as.factor(wg)))
```

![plot of chunk gastro](figure/gastro2.png) 

bronchiolite
------------

```r
bronchio <- d1[substr(d1$DP, 1, 3) == "J21", c("DP", "ENTREE")]
bronchio <- bronchio[complete.cases(bronchio), ]
bronchio$date <- as.Date(bronchio$ENTREE)
hist(bronchio$date, breaks = 18, freq = TRUE, col = "slategray1", main = "2013 - Bronchiolites", 
    xlab = "")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 

Grippe
------

```r
grippe <- d1[substr(d1$DP, 1, 3) == "J11" | substr(d1$DP, 1, 3) == "J10" | substr(d1$DP, 
    1, 3) == "J09", c("DP", "ENTREE")]
grippe <- grippe[complete.cases(grippe), ]
grippe$date <- as.Date(grippe$ENTREE)
hist(grippe$date, breaks = 18, freq = TRUE, col = "slategray1", main = "2013 - Syndromes grippaux", 
    xlab = "")
```

![plot of chunk grippe](figure/grippe.png) 

```r

par(mfrow = c(1, 1))
```

malaises
--------

```r
malaise <- d1[substr(d1$DP, 1, 3) == "R55", c("DP", "ENTREE")]
malaise <- malaise[complete.cases(malaise), ]
malaise$date <- as.Date(malaise$ENTREE)
hist(malaise$date, breaks = 18, freq = TRUE, col = "slategray1")
```

![plot of chunk malaises](figure/malaises.png) 

malaise selon INVS (canicule):

```r
malaise <- d1[substr(d1$DP, 1, 3) == "R55" | substr(d1$DP, 1, 3) == "R53" | 
    substr(d1$DP, 1, 3) == "R42", c("DP", "ENTREE")]
malaise <- malaise[complete.cases(malaise), ]
malaise$date <- as.Date(malaise$ENTREE)
hist(malaise$date, breaks = 18, freq = TRUE, col = "slategray1", main = "Malaises (INVS)")
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-131.png) 

```r
plot(as.factor(malaise$date), col = "slategray1", las = 1, main = "Malaises (INVS)")
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-132.png) 

AVC
----
code SIM10: I60 à I64
**complete.cases** permet de supprimer les enregistrements vides

```r
avc <- d1[substr(d1$DP, 1, 3) >= "I60" & substr(d1$DP, 1, 3) <= "I64", c("DP", 
    "ENTREE", "FINESS", "AGE", "SEXE")]
avc <- avc[complete.cases(avc), ]
nrow(avc)
```

```
## [1] 993
```

```r
summary(avc$FINESS)
```

```
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##        22         6       222         0         7       231       100 
##       Mul       Odi       Sel       Wis 670780055 
##       241         1       101        29        33
```

```r
summary(avc$AGE)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     5.0    63.0    76.0    72.2    84.0   102.0
```

```r
summary(avc$SEXE)
```

```
##   F   I   M 
## 516   0 477
```

Le SAU des HUS reçoit peu d' AVC alors que c'est la meilleure filière. Les résultats sont faussés par l'UNV.

Douleur thoracique
------------------
code SIM10: I20 à I25

```r
idm <- d1[substr(d1$DP, 1, 3) >= "I20" & substr(d1$DP, 1, 3) <= "I25", c("DP", 
    "ENTREE", "FINESS", "AGE", "SEXE")]
idm <- idm[complete.cases(idm), ]
nrow(idm)
```

```
## [1] 485
```

```r
summary(idm$FINESS)
```

```
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##        36         3        66         0        18        72       118 
##       Mul       Odi       Sel       Wis 670780055 
##        67         1        41        30        33
```

```r
summary(idm$AGE)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       2      54      65      65      79      98
```

```r
summary(idm$SEXE)
```

```
##   F   I   M 
## 186   0 299
```

Lésions traumatiques
--------------------
codes CIM10 S00–T98

```r
trauma <- d1[substr(d1$DP, 1, 3) >= "S00" & substr(d1$DP, 1, 3) <= "T98", c("DP", 
    "ENTREE", "FINESS", "AGE", "SEXE")]
trauma <- trauma[complete.cases(trauma), ]
nrow(trauma)
```

```
## [1] 42780
```

```r
summary(trauma$FINESS)
```

```
##       3Fr       Alk       Col       Dia       Geb       Hag       Hus 
##      2787      1090     11944         0      3666      5743       660 
##       Mul       Odi       Sel       Wis 670780055 
##      5542      2396      6759      2063       130
```

```r
summary(trauma$AGE)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0    13.0    27.0    33.3    50.0   106.0
```

```r
summary(trauma$SEXE)
```

```
##     F     I     M 
## 18703     1 24076
```

Etude HUS
----------------

```r
geb <- d1[d1$FINESS == "Geb", ]
```

Orientation des patients 

```r
summary(geb$MODE_SORTIE)
```

```
##        NA  Mutation Transfert  Domicile     Décès      NA's 
##         0         1         6      2281         0      5081
```

```r
summary(geb$ORIENTATION)
```

```
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##     1     0     1     0     2     0     0     0     0     0     1     0 
##  UHCD  NA's 
##     0  7364
```

Mode d'arrivée aux urgences:

```r
summary(as.factor(geb$TRANSPORT))
```

```
##  AMBU PERSO  SMUR  VSAB  NA's 
##   698  6139     1   462    69
```

Heure d'arrivée aux urgences

```r
e <- ymd_hms(geb$ENTREE)
h <- hour(e)
summary(h)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0      10      14      14      18      23
```

```r
hist(h, breaks = 23, xlab = "Heures", main = "CH HUS - Horaire de fréquentation du SU")
```

![plot of chunk geb_arrive](figure/geb_arrive1.png) 

```r
t <- table(h)
t2 <- as.integer(t)
c <- clock24.plot(t2, clock.pos = 1:24, lwd = 3)
```

![plot of chunk geb_arrive](figure/geb_arrive2.png) 

```r
c <- clock24.plot(t2, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F)
```

![plot of chunk geb_arrive](figure/geb_arrive3.png) 

```r
# nécessite la librairie openintro
clock24.plot(t2, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F, poly.col = fadeColor("blue", fade = "10"))
```

![plot of chunk geb_arrive](figure/geb_arrive4.png) 

```r
clock24.plot(t2, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F, poly.col = fadeColor("blue", fade = "10"), line.col = fadeColor("blue", 
        fade = "10"))
```

![plot of chunk geb_arrive](figure/geb_arrive5.png) 

Idem pour les sorties

```r
s <- ymd_hms(geb$SORTIE)
t3 <- as.integer(table(hour(s)))
clock24.plot(t3, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures de sortie des urgences", 
    show.grid.labels = F)
```

![plot of chunk geb_sorties](figure/geb_sorties.png) 

Combinaison entrée-sortie

```r
t4 <- rbind(t2, t3)
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F)
```

![plot of chunk geb_es](figure/geb_es1.png) 

```r
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F, line.col = c("red", "blue"))
```

![plot of chunk geb_es](figure/geb_es2.png) 

```r
fadeBlue <- fadeColor("blue", fade = "15")
fadeRed <- fadeColor("red", fade = "15")
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F, line.col = c(fadeRed, fadeBlue), poly.col = c(fadeRed, 
        fadeBlue))
```

![plot of chunk geb_es](figure/geb_es3.png) 

Entrées selon la période du jour: nuit profonde NP (0h-8h = 1), journée JO (8h-20h = 2), soir SR (20h-24h = 3). La date/heure d'entrée est transformée en heure entière par la fonction *hour*. hest à son tour segmenté en 3 périodes.

```r
e <- ymd_hms(geb$ENTREE)
h <- hour(e)
b <- cut(h, c(0, 8, 20, 24), labels = c("NP", "JO", "SR"))
bp <- summary(as.factor(b))
barplot(bp)
```

![plot of chunk geb jour](figure/geb jour1.png) 

```r
round(prop.table(bp) * 100, 2)
```

```
##    NP    JO    SR  NA's 
## 11.28 78.15  8.97  1.60
```

```r
barplot(round(prop.table(bp) * 100, 2), ylab = "% des passages", sub = "NP = 0h-8h", 
    ylim = c(0, 100), main = "CH HUS\n Passages nuit profonde - jour - soirée")
```

![plot of chunk geb jour](figure/geb jour2.png) 

```r
t <- table(geb$GRAVITE, b)
t
```

```
##    b
##       NP   JO   SR
##   1   30  225   36
##   2  787 5475  620
##   3   10   31    2
##   4    1    6    1
##   D    0    1    0
##   P    3    9    2
```

```r
barplot(t, beside = T, col = 1:7)
```

![plot of chunk geb jour](figure/geb jour3.png) 

Mode sortie en fonction de la période

```r
t <- table(geb$MODE_SORTIE, b)
t
```

```
##            b
##               NP   JO   SR
##   NA           0    0    0
##   Mutation     0    1    0
##   Transfert    0    6    0
##   Domicile   188 2005   78
##   Décès        0    0    0
```

```r
t <- table(geb$ORIENTATION, b)
```

CCL: à HUS tout le monde rentre à la maison !

#### Calcul des heures d'arrivées pour l'ensemble des établissements

```r
e <- ymd_hms(d1$ENTREE)
h <- hour(e)
summary(h)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0    10.0    14.0    13.9    18.0    23.0
```

```r
hist(h, breaks = 23, xlab = "Heures", main = "Alsace - Horaire de fréquentation du SU")
```

![plot of chunk total arrivee](figure/total arrivee1.png) 

```r
t <- table(h)
als_entree <- as.integer(t)
c <- clock24.plot(als_entree, clock.pos = 1:24, lwd = 3, show.grid.labels = F)
```

![plot of chunk total arrivee](figure/total arrivee2.png) 

```r
c <- clock24.plot(als_entree, clock.pos = 1:24, rp.type = "p", main = "Alsace", 
    xlab = "Heures d'arrivée aux urgences", show.grid.labels = F)
```

![plot of chunk total arrivee](figure/total arrivee3.png) 

#### Comparaison Alsace - HUS
Les calculs sont exprimés en %

```r
e <- ymd_hms(geb$ENTREE)
h <- hour(e)
t <- table(h)
t2 <- as.integer(t)
t4 <- rbind(prop.table(t2), prop.table(als_entree))
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "Alsace - HUS (rouge)", 
    xlab = "Heures d'arrivée aux urgences", show.grid.labels = F, line.col = c("red", 
        "blue"), radial.lim = c(0, 0.1))
legend(0.09, -0.09, c("CH", "Alsace"), col = c("red", "blue"), lty = 1, cex = 0.8)
```

![plot of chunk als-geb](figure/als-geb1.png) 

```r

# Profil entrées de HUS versus le profil régional
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "Alsace - HUS (rouge)", 
    xlab = "Heures d'arrivée aux urgences", show.grid.labels = F, line.col = c("red", 
        fadeBlue), poly.col = c(NA, fadeBlue), radial.lim = c(0, 0.1))
```

![plot of chunk als-geb](figure/als-geb2.png) 

#### Comparaison Alsace - Wissembourg

```r
wis <- d1[d1$FINESS == "Wis", ]
e <- ymd_hms(wis$ENTREE)
h <- hour(e)
t <- table(h)
t2 <- as.integer(t)
t4 <- rbind(prop.table(t2), prop.table(als_entree))
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "Alsace - CH de Wissembourg", 
    xlab = "Heures d'arrivée aux urgences", show.grid.labels = F, line.col = c("red", 
        "blue"), radial.lim = c(0, 0.1))
legend(0.09, -0.09, c("CH", "Alsace"), col = c("red", "blue"), lty = 1, cex = 0.8)
```

![plot of chunk als-wis](figure/als-wis.png) 

#### comparaison Alsace - HUS

```r
hus <- d1[d1$FINESS == "Hus", ]
e <- ymd_hms(hus$ENTREE)
h <- hour(e)
t <- table(h)
t2 <- as.integer(t)
t4 <- rbind(prop.table(t2), prop.table(als_entree))
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "Alsace - CHU Strasbourg", 
    xlab = "Heures d'arrivée aux urgences", show.grid.labels = F, line.col = c("red", 
        "blue"), radial.lim = c(0, 0.1))
legend(0.09, -0.09, c("CH", "Alsace"), col = c("red", "blue"), lty = 1, cex = 0.8)
```

![plot of chunk unnamed-chunk-17](figure/unnamed-chunk-17.png) 

#### Test de la fonction*passages*

```r
par(mfrow = c(2, 2))
source("../mes_fonctions.R")
passages("Hus", "HUS", sens = 3)
passages("Mul", "CH Mulhouse", sens = 3)
passages("Col", "CH Colmar", sens = 3)
passages("Hag", "CH Haguenau", sens = 3)
```

![plot of chunk passages](figure/passages1.png) 

```r

passages("Sel", "CH Selestat", sens = 3)
passages("Odi", "Clinique Ste Odile", sens = 3)
passages("Dia", "Diaconnat - Fonderie", sens = 3)
passages("Tan", "CH Thann", sens = 3)
```

```
## Warning: All formats failed to parse. No formats found.
```

```
## Warning: All formats failed to parse. No formats found.
```

![plot of chunk passages](figure/passages2.png) 

```r

passages("3Fr", "Trois frontières", sens = 3)
passages("Alk", "CH Alkirch", sens = 3)
passages("Sav", "CH Saverne", sens = 3)
```

```
## Warning: All formats failed to parse. No formats found.
```

```
## Warning: All formats failed to parse. No formats found.
```

```r
par(mfrow = c(1, 1))
```

![plot of chunk passages](figure/passages3.png) 


Etude HUS
----------------

```r
Hus <- d1[d1$FINESS == "Hus", ]
nrow(Hus)
```

```
## [1] 16298
```

```r
min(Hus$ENTREE)
```

```
## [1] "2013-01-01 00:11:00"
```

```r
max(Hus$ENTREE)
```

```
## [1] "2013-05-30 23:47:00"
```

comparaison entre RPU attendu et RPU transmis. Nécessite le fichier *sau2013*. Les données sont dans le dataframe *d*. Les données hus sont isolées dans *dhus*

```r
load("../SAU2013/sau2013.Rda")
dhus <- d[d$hop == "HUS", ]
sum(dhus$TOTAL.passages, na.rm = T)
```

```
## [1] 41561
```

```r

# hus.serv: DU des Hus. HTP adultes, HTP gynéco, HTP pédiatrie, NHC et
# CCOM (Sos mains)
hus.serv <- as.factor(dhus$ser2)
summary(hus.serv)
```

```
## aHTP CCOM gHTP  NHC pHTP NA's 
##  121  122  121  121  243  242
```

```r
tapply(dhus$TOTAL.passages, hus.serv, sum)
```

```
##  aHTP  CCOM  gHTP   NHC  pHTP 
## 11840  2839  3310 10324 13248
```

```r
# RPU uniquement du au SU HTP et NHC
hus.rpu <- subset(dhus, ser2 == "aHTP" | ser2 == "NHC")
n <- sum(hus.rpu$TOTAL.passages)
print("Prévision2013:")
```

```
## [1] "Prévision2013:"
```

```r
n * 3
```

```
## [1] 66492
```

```r

a <- c(nrow(Hus), n)
names(a) = c("RPU déclarés", "RPU Attendus")
barplot(a, main = "HUS - 1er quadrimestre 2013")
```

![plot of chunk hus_attendu](figure/hus_attendu.png) 

```r
a[1] * 100/a[2]
```

```
## RPU déclarés 
##        73.53
```

Les urgences pédiatriques sont divisées en 2, médicales et chirurgicales. Il y a donc 2 données par jour

```r
hus.ped <- subset(dhus, ser2 == "pHTP")
nped <- sum(hus.ped$TOTAL.passages)
print("Prévision2013:")
```

```
## [1] "Prévision2013:"
```

```r
nped * 3
```

```
## [1] 39744
```

```r

print("Total adulte + pédiatrie:")
```

```
## [1] "Total adulte + pédiatrie:"
```

```r
ntot <- n + nped
ntot
```

```
## [1] 35412
```

```r
print("total annuel:")
```

```
## [1] "total annuel:"
```

```r
ntot * 3
```

```
## [1] 106236
```



Orientation des patients 

```r
summary(Hus$MODE_SORTIE)
```

```
##        NA  Mutation Transfert  Domicile     Décès      NA's 
##         0      8897         0       461         0      6940
```

```r
mean(is.na(Hus$MODE_SORTIE))
```

```
## [1] 0.4258
```

```r
summary(Hus$ORIENTATION)
```

```
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##     0     0     0     0   233     0     0     0     0     0     0     0 
##  UHCD  NA's 
##  9142  6923
```

```r
mean(is.na(Hus$ORIENTATION))
```

```
## [1] 0.4248
```

```r

mean(is.na(Hus$MOTIF))
```

```
## [1] 1
```

```r
mean(is.na(Hus$DESTINATION))
```

```
## [1] 0.4468
```

```r
mean(is.na(Hus$TRANSPORT_PEC))
```

```
## [1] 0.9984
```

```r
mean(is.na(Hus$PROVENANCE))
```

```
## [1] 0.9581
```

```r
mean(is.na(Hus$TRANSPORT))
```

```
## [1] 0.7261
```

```r
mean(is.na(Hus$MODE_ENTREE))
```

```
## [1] 0
```

```r
mean(is.na(Hus$COMMUNE))
```

```
## [1] 0
```

```r
mean(is.na(Hus$GRAVITE))
```

```
## [1] 0.5644
```

```r
mean(is.na(Hus$DP))
```

```
## [1] 0.6676
```

Mode d'arrivée aux urgences:

```r
summary(as.factor(Hus$TRANSPORT))
```

```
##  AMBU    FO PERSO  SMUR  VSAB  NA's 
##  2358     9   790   291  1016 11834
```

```r
mean(is.na(Hus$TRANSPORT))
```

```
## [1] 0.7261
```

Heure d'arrivée aux urgences

```r
e <- ymd_hms(Hus$ENTREE)
h <- hour(e)
summary(h)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0    11.0    16.0    14.6    19.0    23.0
```

```r
hist(h, breaks = 23, xlab = "Heures", main = "CH HUS - Horaire de fréquentation du SU", 
    col = c(rep(1, 8), rep(2, 12), rep(3, 4)))
```

![plot of chunk Hus_arrive](figure/Hus_arrive1.png) 

```r
t <- table(h)
t2 <- as.integer(t)
c <- clock24.plot(t2, clock.pos = 1:24, lwd = 3)
```

![plot of chunk Hus_arrive](figure/Hus_arrive2.png) 

```r
c <- clock24.plot(t2, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F)
```

![plot of chunk Hus_arrive](figure/Hus_arrive3.png) 

```r
# nécessite la librairie openintro
clock24.plot(t2, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F, poly.col = fadeColor("blue", fade = "10"))
```

![plot of chunk Hus_arrive](figure/Hus_arrive4.png) 

```r
clock24.plot(t2, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F, poly.col = fadeColor("blue", fade = "10"), line.col = fadeColor("blue", 
        fade = "10"))
```

![plot of chunk Hus_arrive](figure/Hus_arrive5.png) 

Idem pour les sorties

```r
s <- ymd_hms(Hus$SORTIE)
mean(is.na(s))
```

```
## [1] 0.3457
```

```r
t3 <- as.integer(table(hour(s)))
clock24.plot(t3, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures de sortie des urgences", 
    show.grid.labels = F)
```

![plot of chunk Hus_sorties](figure/Hus_sorties.png) 

Combinaison entrée-sortie

```r
t4 <- rbind(t2, t3)
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F)
```

![plot of chunk Hus_es](figure/Hus_es1.png) 

```r
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F, line.col = c("red", "blue"))
```

![plot of chunk Hus_es](figure/Hus_es2.png) 

```r
fadeBlue <- fadeColor("blue", fade = "15")
fadeRed <- fadeColor("red", fade = "15")
clock24.plot(t4, clock.pos = 1:24, rp.type = "p", main = "HUS", xlab = "Heures d'arrivée aux urgences", 
    show.grid.labels = F, line.col = c(fadeRed, fadeBlue), poly.col = c(fadeRed, 
        fadeBlue))
```

![plot of chunk Hus_es](figure/Hus_es3.png) 

Entrées selon la période du jour: nuit profonde NP (0h-8h = 1), journée JO (8h-20h = 2), soir SR (20h-24h = 3). La date/heure d'entrée est transformée en heure entière par la fonction *hour*. hest à son tour segmenté en 3 périodes.

```r
e <- ymd_hms(Hus$ENTREE)
h <- hour(e)
b <- cut(h, c(0, 8, 20, 24), labels = c("NP", "JO", "SR"))
bp <- summary(as.factor(b))
barplot(bp)
```

![plot of chunk Hus jour](figure/Hus jour1.png) 

```r
round(prop.table(bp) * 100, 2)
```

```
##    NP    JO    SR  NA's 
## 11.92 69.38 16.81  1.89
```

```r
barplot(round(prop.table(bp) * 100, 2), ylab = "% des passages", sub = "NP = 0h-8h", 
    ylim = c(0, 100), main = "CH HUS\n Passages nuit profonde - jour - soirée")
```

![plot of chunk Hus jour](figure/Hus jour2.png) 

```r
t <- table(Hus$GRAVITE, b)
t
```

```
##    b
##       NP   JO   SR
##   1  147  710   91
##   2  847 2662  310
##   3  404 1245  139
##   4   55  184   21
##   5   13   30    5
```

```r
barplot(t, beside = T, col = 1:5, main = "Gravité en fonction de la période")
legend(1, 2000, c(1:5), col = c(1:5), pch = 15, cex = 0.8)
```

![plot of chunk Hus jour](figure/Hus jour3.png) 

Mode sortie en fonction de la période

```r
t <- table(Hus$MODE_SORTIE, b)
t
```

```
##            b
##               NP   JO   SR
##   NA           0    0    0
##   Mutation  1764 6169  670
##   Transfert    0    0    0
##   Domicile    62  348   46
##   Décès        0    0    0
```

```r
t <- table(Hus$ORIENTATION, b)
```







