# Variance

## Théorème de #Konig-Huygens

### Enoncé

> Théorème de #konig-huygens
>
> Pour toute variable aléatoire réelle X qui admet un moment d'ordre 2, on a :
> $Var(X) \equiv \mathop{\mathbb{E}}[(X-\mathop{\mathbb{E}}[X])^{2}] = \mathop{\mathbb{E}}[X^{2}]-(\mathop{\mathbb{E}}[X])^{2}$ 

### Démonstration

$$
\begin{aligned}
\mathop{\mathbb{E}}[(X-\mathop{\mathbb{E}}[X])^{2}]  = \mathop{\mathbb{E}}[X^{2}-2X\mathop{\mathbb{E}}[X] + (\mathop{\mathbb{E}}[X])^{2}]  \\
= \mathop{\mathbb{E}}[X^{2}] - \mathop{\mathbb{E}}[2X\mathop{\mathbb{E}}[X]]+ \mathop{\mathbb{E}}[(\mathop{\mathbb{E}}[X])^{2}] \\
= \mathop{\mathbb{E}}[X^{2}]-2\mathop{\mathbb{E}}[X]\mathop{\mathbb{E}}[X] + (\mathop{\mathbb{E}}[X])^{2} \\
= \mathop{\mathbb{E}}[X^{2}]-(\mathop{\mathbb{E}}[X])^{2}
\end{aligned}
$$
 
 