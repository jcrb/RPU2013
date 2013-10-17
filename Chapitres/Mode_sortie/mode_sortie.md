Mode de sortie
========================================================

```r
getwd()
```

```
## [1] "/home/jcb/Documents/Resural/Stat Resural/RPU2013/Chapitres/Mode_sortie"
```

```r
source("../prologue.R")
d1 <- foo(path)
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

Trois items interviennent dans cetteanalyse:
- le mode de sortie
- la destination
- l'orientation

La destination
--------------
C'est l'item le plus simple et le RPU lui décrit 4 niveaux:
- mutation
- transfert (ces 2niveaux définissant l'hospitalisation)
- le décès
- le retour à domicile

On dispose d'une population de n = 249039 RPU.

On forme un sous-groupe constitué des RPU dont l'item *DESTINATION* est renseigné (non nul):

```r
ms <- d1[!is.na(d1$MODE_SORTIE), ]
non_renseigne <- nrow(d1) - nrow(ms)
prop_non_renseigne <- round(non_renseigne * 100/nrow(d1), 2)
```

On obtient un sous-groupe de 212320 RPU. Il y a donc 36719 RPU non renseignés soit 14.74 % de l'effectif.

Les MODE_SORTIE renseignés se répartissent ainsi:

```
##        NA  Mutation Transfert  Domicile     Décès 
##         0     48898      3665    159755         2
```

TODO: on s'intéresse aux MODE_SORTIE non renseignés: 
ms2<-d1[is.na(d1$MODE_SORTIE),]
Que passe t'il si on fait summary(ms2$DESTINATION) ?

La destination
--------------
Cet item affine le MODE_SORTIE, en précisant:
- pour les patients hospitalisés, leur destination: MCO, SSR, SLD ou PSY
- et pour les patients non hospitalisés, 2 destinations qui ne sont ni l'hôpital, ni la maison à savoir HAD et HMS.
On suppose implicitement que les non réponses correspondent au retour à domicile.

Dans un premier groupe on à la DESTINATION lorsque MODE_SORTIE est renseigné (ms):

```
##     NA    MCO    SSR    SLD    PSY    HAD    HMS   NA's 
##      0  51442     74     12    894      3     21 159874
```

la destination n'est pas renseignées pour 159874 RPU ce qui peut correspondre à un retour à la maison où une non réponse.

Dans un premier temps on s'intéresse à l'ORIENTATION des RPU où MODE_SORTIE est renseigné mais DESTINATION n'est pas renseigné:

```
##   CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO     SC 
##     92    198     13      2     53      1   2284      9   1047      4 
##   SCAM     SI   UHCD   NA's 
##    386     22    206 155557
```

Dans ce sous-groupe, l'analyse de l'item ORIENTATION ne devrait retouner que des NA (retour à domicile) ou une ORIENTATION appartenant au sous ensemble {FUGUE, SCAM, PSA, REO}


```
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##  5340     0    66    19 12341    71    10   689    22   983     0   947 
##  UHCD  NA's 
## 22482  9476
```


