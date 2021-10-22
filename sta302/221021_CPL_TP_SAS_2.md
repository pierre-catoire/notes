
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
- $\alpha = \begin{pmatrix} \alpha_{0i} \\ \alpha_{1i} \end{pmatrix} \sim \mathcal{N}\Bigg( \begin{pmatrix}  0 \\ 0 \end{pmatrix},\mathcal{B} = \begin{bmatrix}  
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

### Estimation des résidus

On a deux types de résidus :

- résidus **marginaux** : $Y_{ij}-\mathbb{E}(Y_{ij}) = \alpha_{0i} + \alpha_{1i}t_{ij} + \epsilon_{ij}$
- résidus **conditionnels** : $Y_{ij}-X^{T}_{ij}\hat{\beta}$
- résidus **conditionnels aux effets aléatoires** = $Y_{ij}-\mathbb{E}(Y_{ij}| \alpha)$

Au total, on souhaite surtout estimer $\epsilon_{ij}$. Cependant il nous faut une estimation de $\alpha$. On ne peut pas les estimer, mais on peut prédire le plus probable : c'est le **BLUP** qui est une prédiction des effets aléatoires.

$Y_{ij}-\mathbb{E}(Y_{ij}| \alpha) = Y_{ij}-X^{T}\hat{\beta}-Z_{ij}^{T}\hat{\alpha}_{i}$

On peut sortir le BLUP dans SAS :
```
proc mixed data = tp.df method = ML covtest;
class id;
model albumin = year histo3 histo4 year*histo3 year*histo4/ s;
random intercept year / subject = id type = VC solution;
run;
```
Par exemple,
- l'intercept prédit par le BLUP du sujet 1 est à `-0.4059`, avec intercept fixe de 3.6332. Ceci signifie que son intercept individuel est `3.6332-0.4059 = 3.2273`(si il est dans le groupe HISTO12).
- l'intercept prédit par le BLUP du sujet 2 est à `0.1783`,  avec intercept fixe de 3.6332 et intercept du groupe histo3 de SAS `-0.03525`. Ceci signifie que s'il est dans le groupe 3, son intercept individuel est  `3.6332-0.4059-0.03525 = 3.19205`.

Pour estimer la normalité des résidus, on peut tracer un histogramme :
```
*On commence par sortir la table des intercepts et pentes du BLUP pour les effets aléatoires via l'instruction ods :;
ods output SolutionR=tp.ea;
proc mixed data = tp.df method = ML covtest;
class id;
model albumin = year histo3 histo4 year*histo3 year*histo4/ s;
random intercept year / subject = id type = VC solution;
run;

*Puis on trace l'histogramme;
proc univariate data=tp.ea;
var estimate;
histogram estimate;
where effect='Intercept';
run;
```

Dans certains modèles, on est intéressé d'estimer les facteurs associés aux estimations des $\alpha_{i}$.

Rappel : $\hat {\alpha_{i}} = \hat{\beta} Z^{T}\hat{V}^{-1}(Y_{i}-X_{i}\hat{\beta})$

Pour tracer les graphiques des résidus : 

```
proc mixed data = tp.df method = ML covtest;
class id drug;
model albumin = year histo3 histo4 year*histo3 year*histo4/ solution residual vciry outp=cond outpm=marg;
random intercept year / subject = id type = VC solution;
run;
```

L'output donne les résidus et les résidus conditionnels.

### Standardisation des résidus.
Les résidus conditionnels ont une variance propre. Il doivent être standardisés pour être comparés. Il existe plusieurs méthodes pour cela : Pearson, Student. Il existe également les résidus de Cholesky.
