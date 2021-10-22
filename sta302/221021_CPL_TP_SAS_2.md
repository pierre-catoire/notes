
---
title: "main"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
df = read.delim("pbc_noExtreme.txt")
```

# STA302 : TP SAS Modèles linéaires mixtes séance 2 (22.10.21)

## Inclusion de variables explicatives :

- Modèle 1 :
$Y_{i,j} = (\beta_{0} + \alpha_{0i}) + (\beta_{1} + \alpha_{1i})t_{i,j} + \beta_{3}X + \epsilon$

avec :
- $\alpha = (\alpha_{0i},\alpha_{1i})^{T} \sim \mathcal{N}\Bigg( (0,0)^{T},\mathcal{B} = \begin{bmatrix}  
\sigma_{0}^{2} & \sigma_{0,1}\\  
\sigma_{0,1} & \sigma_{1}^{2}   
\end{bmatrix}\Bigg)$

- $\epsilon_{i,j} \sim \mathcal{N}\big(0,\sigma_{e}^{2}\big)$

### Comparaison avec les modèles 

- le modèle 1.a. est intercept similaire, pente aléatoire dépendante des Xi :
	- $Y_{i,j} = \beta_{0} + (\beta_{1} + \alpha_{1i})t_{i,j} + \beta_{3}X + \epsilon$
- le modèle 1.b est intercept similaire, indépendance du temps, indépendance des Xi :
	- $Y_{i,j} = \beta_{0} + \epsilon$
- le modèle 1.c est intercept dépendant de X, indépendance du temps
	- $Y_{i,j} = \beta_{0} + \beta_{3}X + \epsilon$
- le modèle 1.c est intercept et pente dépendants de X
	- $Y_{i,j} = (\beta_{0} + \alpha_{0i} + \beta_{3}X ) + (\beta_{1} + \alpha_{1i} + \beta_{4}X)t_{i,j} + \epsilon$
	- de plus, l'intercept aléatoire semble indépendant de la pente aléatoire :
	- $\mathcal{B} = \begin{bmatrix}  
\sigma_{0}^{2} & 0\\  
0 & \sigma_{1}^{2}   
\end{bmatrix}$

```
proc mixed data = tp.df method = ML covtest;
class id drug;
model albumin = year drug year*drug/ s;
random intercept year / subject = id type = VC; *VC = variance component = que des variances = indépendance des effets aléatoires (car covariance nulle);
run;
```



On souhaite avoir trois classes d'HISTO :

- histology = 1 ou 2
- histology = 3
- histology = 4

```
data tp.df;
set tp.df;
if histologic < 3 then histo = 1;
else histo = 0;
if histologic = 3 then histo3 = 1;
else histo3 = 0;
if histologic = 4 then histo4 = 1;
else histo4 = 0;
run;
```

Le modèle décrit est :
$Y_{i,j} = (\beta_{0} + \alpha_{0i} + \beta_{2,1}X_{iHISTO3} + \beta_{2,2}X_{iHISTO4}) \\ + (\beta_{1} + \alpha_{1i} + \beta_{3,1}X_{i,HISTO3} + \beta_{3,2}X_{iHISTO4})t_{ij} \\+ \epsilon$

Les paramètres à estimer sont : $\beta_{0},\beta_{2,1},\beta_{2,2},\beta_{1}, \beta_{3,1},\beta_{3,2},\sigma_{0}^{2},\sigma_{1}^{2},\sigma_{\epsilon}^{2}$ soit 9 paramètres.

> NB : le plan général d'une analyse :
> 1. Description des données
> 2. Définition du modèle théorique
> 3. Définition de l'évolution du temps et la structure des effets aléatoires (matrice de variance-covariance) via l'estimation du modèle
> 4. Etude des variables explicatives via l'estimation du modèle
> 5. Etude de l'adéquation
> 
> Et on interprète à chaque étape.

#### Estimation du modèle avec introduction du type histologique comme variable explicative

```
proc mixed data = tp.df method = ML covtest;
class id;
model albumin = year histo3 histo4 year*histo3 year*histo4/ s;
random intercept year / subject = id type = VC;
run;
```

Solution pour les effets fixes :
| Effet| Estimation| p-value|
|--|--|--|
| Intercept | 3.6332| < 0.001
| Year | -0.07918 | < 0.001
| Histo3 | -0.03525 | 0.3788
| Histo4 | -0.2083 | < 0.001
| year*histo3 | 0.007517 | 0.5698
| year*histo4 | 0.002856 | 0.8162


## Test de différence de paramètres

Par exemple, on veut savoir si les patients de type histologique 3 et 4 ont la même albumine à t0.
$\mathbb{E}(Y|t=0, HIST03 = 0, HISTO4 = 1) - \mathbb{E}(Y|t=0, HIST03 = 1, HISTO4 = 0)$
$\leftrightarrow (\beta_{0}+ \beta_{2,2}) - (\beta_{0} + \beta_{2,1})$
$\leftrightarrow \beta_{2,2} - \beta_{2,1}$
$\leftrightarrow 1 \times \beta_{2,2} + (-1) \times \beta_{2,1}$

```
proc mixed data = tp.df method = ML covtest;
class id;
model albumin = year histo3 histo4 year*histo3 year*histo4/ s;
random intercept year / subject = id type = VC;
estimate 'diff year=0 entre histo 4 et 3' int 0 year 0 histo3 -1 histo4 1 histo3*year 0 histo4*year 0;
run;
```

Exercice : estimer :
- le niveau d'albumine à y=0 chez histo4 : $\beta_{0}+\beta_{2,2}$
- le niveau d'albumine à y=5 chez histo4 : $(\beta_{0}+\beta_{2,2}) + (\beta_{1}+\beta_{3,2})\times5$
- le niveau d'albumine à y=5 entre histo4 et histo3 $(\beta_{2,2}-\beta_{2,1}) + (\beta_{3,2}-\beta_{3,1})\times5$

```
proc mixed data = tp.df method = ML covtest;
class id;
model albumin = year histo3 histo4 year*histo3 year*histo4/ s;
random intercept year / subject = id type = VC;
estimate 'Niveau d albumine à y=0 chez histo4' int 1 year 0 histo3 0 histo4 1 histo3*year 0 histo4*year 0;
estimate 'Niveau d albumine à y=5 chez histo4' int 1 year 5 histo3 0 histo4 1 histo3*year 0 histo4*year 1;
estimate 'Niveau d albumine à y=5 entre histo4 et histo3' int 0 year 0 histo3 -1 histo4 1 histo3*year -5 histo4*year 5;
run;
```


