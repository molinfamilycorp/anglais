# Fiches d'anglais — seconde

Une fiche par séance hebdomadaire de 1 h 30 : deux ou trois exercices, un texte d'auteur
avec questions, une version d'une vingtaine de lignes. Progression : `plan.md`.

```
fiche.cls          classe LaTeX (bascule énoncé / corrigé)
Makefile
plan.md            progression des 20 séances
fiches/fiche01.tex
pdf/               sortie
build/             fichiers intermédiaires
```

## Compiler

```sh
make                              # tous les PDF
make pdf/fiche01-corrige.pdf      # un seul
make clean
```

Nécessite `babel-french`, `mdframed`, `lineno`, `enumitem`, `titlesec`, `needspace`.
La police par défaut est Latin Modern, présente dans toute installation, même partielle.

```sh
tlmgr install charter helvetic     # puis \documentclass[charter]{fiche}
```

## Un source, deux PDF

`fiche.cls` définit le booléen `\ifcorrige` ; le Makefile compile deux fois le même `.tex`.

```sh
pdflatex -jobname=fiche01-enonce  "\input{fiches/fiche01.tex}"
pdflatex -jobname=fiche01-corrige "\PassOptionsToClass{corrige}{fiche}\input{fiches/fiche01.tex}"
```

## Macros

| macro | énoncé | corrigé |
|---|---|---|
| `\trou{réponse}` | trait à compléter | réponse en couleur |
| `\corr{texte}` | rien | texte en couleur |
| `\note[titre]{texte}` | rien | encadré de commentaire |
| `\lignes{n}` | n lignes à écrire | rien |
| `\rappel{texte}` | encadré de règle | idem |

Structure : `\metadonnees{num}{titre}{bloc}`, `\entete`, `\objectifs{}`,
`\exercice[durée]{titre}`, `\partiel[durée]{titre}`, `\consigne{}`, `\source{}`.

Textes anglais : environnements `texte` et `version` (lignes numérotées de 5 en 5),
`\en{...}` pour une phrase anglaise isolée dans un paragraphe français,
`\gl[lemme]{mot}{glose}` pour une note de bas de page.

## Textes

Auteurs du domaine public (morts avant 1956), reproduits intégralement, dans l'édition
la plus standard quand il en existe plusieurs. Les mots rares sont glosés en note de bas
de page ; les mots du lexique final ne le sont pas. Pour un texte contemporain, fournir
l'extrait.
