RPU2013 Analyse 2
========================================================

On forme une séquence de 365 dates allant du 1er janvier au 31 décembre. Days(1) est égal au nombre de secondes dans 1 journée:

```r
library("lubridate")
library("zoo")
```

```
## Attaching package: 'zoo'
```

```
## The following object(s) are masked from 'package:base':
## 
## as.Date, as.Date.numeric
```

```r
library("xts")

b1 <- as.Date("2013-01-01")
b2 <- as.Date("2013-12-31")
b <- seq(b1, b2, 1)
```

Le tout est transformé en type de jour (dimanche = 1). Summary donne le nombre de type de jours en 2013

```r
b3 <- wday(b)
b4 <- summary(as.factor(b3))
b4
```

```
##  1  2  3  4  5  6  7 
## 52 52 53 52 52 52 52
```


```r
load("rpu2013d0107.Rda")
d1 <- d0107
rm(d0107)

# nombre de RPU par type de jour de la semaine:
e <- ymd_hms(d1$ENTREE)
a <- summary(as.factor(wday(e)))
a
```

```
##     1     2     3     4     5     6     7 
## 28591 29737 27681 25799 27050 26150 28094
```

```r
# nb de RPU par type de jour divisé par le nombre de fois où ce jour
# apparait dans l'année:
round(a/b4, 1)
```

```
##     1     2     3     4     5     6     7 
## 549.8 571.9 522.3 496.1 520.2 502.9 540.3
```

```r

barplot(a, xlab = "Jour de la semaine (1 = dimanche)", ylab = "Nombre de RPU")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-31.png) 

```r
barplot(round(a/b4, 1))
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-32.png) 


Utilisation de zoo - moyenne mobile (moving average)
====================================================
nécessite lubridate

on part de 

```r
e <- ymd_hms(d1$ENTREE)
```


on arrondit au jour entier:  

```r
f <- round_date(e, "day")
e[1]
```

```
## [1] "2013-01-01 00:04:00 UTC"
```

```r
f[1]
```

```
## [1] "2013-01-01 UTC"
```

```r
g <- summary(as.factor(f))
g
```

```
## 2013-06-22 2013-06-09 2013-06-17 2013-06-23 2013-07-15 2013-06-03 
##       1134       1119       1116       1109       1092       1086 
## 2013-07-28 2013-07-29 2013-06-10 2013-06-08 2013-06-16 2013-07-08 
##       1085       1082       1080       1073       1071       1056 
## 2013-04-14 2013-06-12 2013-04-06 2013-05-19 2013-07-09 2013-06-11 
##       1046       1045       1043       1039       1037       1035 
## 2013-06-24 2013-06-15 2013-07-14 2013-02-11 2013-04-08 2013-07-27 
##       1035       1032       1028       1027       1025       1025 
## 2013-06-25 2013-07-16 2013-05-06 2013-05-20 2013-06-13 2013-01-21 
##       1024       1024       1020       1018       1017       1009 
## 2013-07-13 2013-07-30 2013-05-11 2013-02-03 2013-07-10 2013-06-18 
##       1009       1009       1006       1001       1001        999 
## 2013-02-17 2013-06-07 2013-07-26 2013-07-11 2013-04-19 2013-06-04 
##        997        996        996        994        992        990 
## 2013-07-07 2013-07-24 2013-03-04 2013-07-01 2013-04-09 2013-04-22 
##        990        990        989        989        988        988 
## 2013-05-10 2013-03-08 2013-06-21 2013-04-20 2013-01-28 2013-04-16 
##        985        982        981        980        979        977 
## 2013-05-18 2013-04-13 2013-06-20 2013-04-29 2013-01-27 2013-04-02 
##        976        975        975        974        973        973 
## 2013-05-26 2013-06-30 2013-01-22 2013-03-31 2013-01-29 2013-05-05 
##        973        973        970        970        967        966 
## 2013-05-07 2013-02-04 2013-07-20 2013-05-28 2013-07-06 2013-04-18 
##        966        965        965        964        961        960 
## 2013-04-15 2013-03-11 2013-04-01 2013-02-01 2013-02-05 2013-02-19 
##        958        957        957        956        956        956 
## 2013-05-22 2013-07-23 2013-03-18 2013-03-29 2013-04-27 2013-06-06 
##        951        950        948        947        944        941 
## 2013-07-05 2013-04-10 2013-05-17 2013-04-30 2013-04-17 2013-07-02 
##        940        939        939        938        937        937 
## 2013-07-12 2013-05-15 2013-06-19 2013-02-16 2013-03-09 2013-04-24 
##        937        936        934        933        933        933 
## 2013-01-23 2013-02-09 2013-02-24    (Other) 
##        931        931        931      94766
```


Cela donne:
e[1]
[1] "2013-01-01 00:04:00 UTC"

[1] "2013-01-01 UTC"

 g<-summary(as.factor(f))
 
 on crée une nouvelle variable **count** qui attribue à chaque enregistrement la valeur 1. Puis on utilise la fonction *aggregate* pour faire la somme des visites aux SU par jour:
 
 ```r
 d1$count <- 1
 g <- aggregate(d1$count, by = list(as.factor(f)), FUN = sum)
 ```

 
 On obtient une matrice de 121 lignes (1er janvier au 1er mai) et 2 colonnes, la date (*Group.1*) et le nombre de visites (*x*)
 
 On fabrique un objet *série temporelle*:
 
 ```r
 h <- ts(g, start = c(2013, 1), frequency = 365)
 summary(h)
 ```
 
 ```
 ##     Group.1            x       
 ##  Min.   :  1.0   Min.   : 306  
 ##  1st Qu.: 53.8   1st Qu.: 862  
 ##  Median :106.5   Median : 925  
 ##  Mean   :106.5   Mean   : 911  
 ##  3rd Qu.:159.2   3rd Qu.: 978  
 ##  Max.   :212.0   Max.   :1134
 ```
 
 ```r
 plot(h[, 2], ylab = "Nb. de passages aux Urgences", main = "Passages aux SU en 2013")
 ```
 
 ![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 

  
 On fabrique un objet *zoo*:
 
 ```r
 h2 <- zoo(h)
 summary(h2)
 ```
 
 ```
 ##      Index         Group.1            x       
 ##  Min.   :2013   Min.   :  1.0   Min.   : 306  
 ##  1st Qu.:2013   1st Qu.: 53.8   1st Qu.: 862  
 ##  Median :2013   Median :106.5   Median : 925  
 ##  Mean   :2013   Mean   :106.5   Mean   : 911  
 ##  3rd Qu.:2013   3rd Qu.:159.2   3rd Qu.: 978  
 ##  Max.   :2014   Max.   :212.0   Max.   :1134
 ```
 
 ```r
 plot(h2[, 2], ylab = "Nb. de passages aux Urgences", main = "Passages aux SU en 2013", 
     xlab = "Jours")
 legend("bottomleft", "moyenne lissée", col = "red", lty = 1, cex = 0.8, bty = "n")
 lines(rollmean(h2[, 2], 7), col = "red")
 ```
 
 ![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 

 
  meilleure solution
  ------------------
  on fabrique un objet **a** qui dait la somme par date des passages aux urgences:
  
  ```r
  a <- tapply(e, as.Date(d1$ENTREE), length)
  a[1:10]
  ```
  
  ```
  ## 2013-01-01 2013-01-02 2013-01-03 2013-01-04 2013-01-05 2013-01-06 
  ##        884        801        686        704        722        691 
  ## 2013-01-07 2013-01-08 2013-01-09 2013-01-10 
  ##        876        694        683        673
  ```

  
  vérification:
  a[1:10]
2013-01-01 2013-01-02 2013-01-03 2013-01-04 2013-01-05 2013-01-06 2013-01-07 2013-01-08 2013-01-09 2013-01-10 
       884        801        686        704        722        691        876        694        683        673 
       
On supprime l'enregistrement 121 correspondant au 1er mai et qui ne contient qu'un élément:
a[121]  2013-05-01 1 
a<-a[-121]



```r
a1 <- summary(a)
a1
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       2     865     926     915     978    1160
```

```r

z <- zoo(a, unique(as.Date(d1$ENTREE)))
plot(z, ylab = "Nb. de passages aux Urgences", main = "Passages aux SU en 2013", 
    xlab = "Période")
legend("topleft", legend = "moyenne lissée", col = "red", lty = 1, cex = 0.8, 
    bty = "n")
lines(rollmean(z[, 2], 7), col = "red")
```

![plot of chunk zoo2](figure/zoo2.png) 

  
Variante avec *xts*
-------------------

```r
x <- as.xts(z)
plot(x)
legend("topleft", legend = "moyenne lissée", col = "red", lty = 1, cex = 0.8, 
    bty = "n")
lines(rollmean(xts(z), 7), col = "red")
```

![plot of chunk xts](figure/xts.png) 


utilisation de rollapply
------------------------
rollapply permet d'appliquer une fonction à une moyenne mobile. On calcule la moyenne mobile sur 7 jours ainsi que son écart-type (ze). Puis on dessine la courbe moyenne (m) ainsi que les 2 courbes correspongant à l'écart-type sup (zes) et inférieur (zei)

calcul de l'écart-type:

```r
r <- rollapply(z, 7, sd)
z <- zoo(a, unique(as.Date(d1$ENTREE)))
m <- rollapply(z, 7, mean)
plot(xts(m), ylim = c(600, 1200))
```

![plot of chunk rooapply](figure/rooapply1.png) 

```r
ze <- rollapply(z, 7, sd)
zes <- m + ze
zei <- m - ze
plot(xts(m), ylim = c(600, 1200), ylab = "Nb. de passages aux Urgences", main = "Passages aux SU en 2013", 
    xlab = "Moyenne lissée")
lines(xts(zes), col = "red")
lines(xts(zei), col = "red")
legend("topleft", legend = c("moyenne lissée", "écart-type"), col = c("black", 
    "red"), lty = 1, cex = 0.8, bty = "n")
```

![plot of chunk rooapply](figure/rooapply2.png) 

