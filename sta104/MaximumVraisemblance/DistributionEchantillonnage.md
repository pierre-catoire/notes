# Distribution d'échantillonnage

Une #statistique est une fonction d'une variable aléatoire, et donc est elle-même une variable aléatoire. Sa #distribution est appellée #distribution-echantillonnage. Elle est parfois calculable, sinon on utilisera une distribution approximée basée sur un résultat asymptotique.

## Distributions d'échantillonnage exactes

- Pour $Y_{i} \sim B(\pi)$ , on a $S_{n}=\sum^{n}_{i=1}[Y_{i}] \sim \mathcal{B}(n,\pi)$.  On a alors $\hat{\pi} = S_{n}/n$ estimateur sans biais de $\pi$.
- Pour $Y_{i} \sim \mathcal{N}(\mu,\sigma^{2})$, alors :
    - $\hat{\mu} = \bar{Y} = \frac{1}{n}\sum^{n}_{i=1}[Y_{i}] \sim \mathcal{N}(\mu,\sigma^{2}/n)$.
    - $s^{2} = \frac{\sum^{n}_{i=1}[(Y_{i}-\bar{Y})^{2}]}{n-1}$ est un estimateur sans biais de $\sigma^{2}$. Par ailleurs, $\frac{(n-1)S^{2}}{\sigma^{2}} \sim \chi^{2}_{(n-1)}$.

> Démonstration de l'estimateur de la loi binomiale :
>
> $P(S_{n} = k) = C^{k}_{n}\pi^{k}(1-\pi)^{n-k}=P(\hat{\pi}=\frac{k}{n})$ 

> Démonstration de la loi d'échantillonnage de $s^{2}$ :
>
> On sait que $\chi^{2}_{n} = \sum^{n}_{i=1}[X_{i}^{2}]$ avec $X_{i} \sim \mathcal{N}(0,1)$.
> On a donc $\sum^{n}_{i=1}[(\frac{Y_{i}-\mu}{\sigma})^{2}] \sim \chi^{2}_{n}$.
> On a $\sum^{n}_{i=1}[(\frac{Y_{i}-\mu}{\sigma})^{2}] \sim \chi^{2}_{n-1}$ car on perd un degré de liberté en estimant $\mu$ par $\bar{Y}$.
> On transforme l'expression en posant
> $\frac{(n-1)}{\sigma^{2}}\frac{\sum^{n}_{i=1}[(Y_{i}-\bar{Y})^{2}]}{n-1}=\frac{(n-1)S^{2}}{\sigma^{2}}$ 

Lorsque $\sigma^{2}$ est inconnu, on la remplace par son estimateur sans biais $S^{2}$. On a alors la statistique du test de Student : $T = \frac{\bar{Y}-\mu}{S/\sqrt{n}} \sim \mathcal{Student}_{(n-1)}$.

> Démonstration de la loi d'échantillonnage de $T$ :
>
> Si $Z \sim \mathcal{N}(0,1)$ et $X_{\nu} \sim \chi^{2}_{n}$,
> par définition $T = \frac{Z}{\sqrt{X_{\nu}/{\nu}}}    \overset{\Delta}{\sim} \mathcal{Student}_{(\nu)}$.
> On reformule par $T = \frac{\sqrt{n}(\bar{Y}-\mu)}{S}   = \frac{\frac{\sqrt{n}(\bar{Y}-\mu)}{\sigma}}{\sqrt{\frac{(n-1)S^{2}/\sigma^{2}}{n-1}}} = \frac{\sqrt{n}(\bar{Y}-\mu)}{S}$  
> Or $\frac{\frac{\sqrt{n}(\bar{Y}-\mu)}{\sigma}}{\sqrt{\frac{(n-1)S^{2}/\sigma^{2}}{n-1}}} = \frac{Z}{\sqrt{X_{\nu - 1}/{(\nu - 1)}}}  \sim \mathcal{Student}_{(\nu -1)}$ 

## Distributions d'échantillonnage asymptotiques

De nombreuses distributions d'échantillonnages ne sont pas calculables de manière exacte. On utilise alors une approximation basée sur une distribution asymptotique, d'après le #theoreme-central-limite.

> Théorème - #theoreme-central-limite :
>
> Pour $Y_{i}, ..., Y_{n}$ avec $Y_{i}$ i.i.d, d'espérance $\mu = \mathop{\mathbb{E}}(Y_{i})$ et de variance $\sigma^{2} = var(Y_{i})$, avec $\bar{Y}=\frac{1}{n} \sum^{n}_{i=1}[Y_{i}]$, et une suite de variables $Z_{n} = \frac{\sqrt{n}(\bar{Y}-\mu)}{\sigma}$
> Alors $\{Z_{n}\}$ converge en distribution vers $\mathcal{N}(0,1)$ lorsque n tend vers l'infini, et on note $Z_{n} \xrightarrow{d} Z \sim \mathcal{N}(0,1)$ ou plus simplement $F_{Z_{n}} \rightarrow \Phi$ avec $\Phi$ fonction de répartition de la loi normale centrée réduite, ce qui signifie $\lim_{n\rightarrow\infty}P(Z_{n} \leq x) = P(Z\leq x) = \Phi(x)$.

En pratique, le #theoreme-central-limite implique que lorsque l'échantillon est de taille assez grande, la distribution de $\hat{Y}$ est approximativement normale, de moyenne $\mu$, de variance $\sigma^{2}/n$.

On peut donc déterminer que :
- pour une proportion, 