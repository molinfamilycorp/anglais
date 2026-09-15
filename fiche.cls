%% fiche.cls — fiche de travail d'anglais, seconde
%% Option « corrige » : affiche réponses et commentaires.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fiche}[2026/09/15 Fiche de travail d'anglais]

\newif\ifcorrige \corrigefalse
\DeclareOption{corrige}{\corrigetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper]{article}

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\IfFileExists{french.ldf}
  {\RequirePackage[english,main=french]{babel}}
  {\RequirePackage[english]{babel}
   \ClassWarningNoLine{fiche}{babel-french absent : composition en anglais}}
\providecommand{\og}{\guillemotleft\,}
\providecommand{\fg}{\,\guillemotright}
\RequirePackage{charter}
\RequirePackage[scaled=0.88]{helvet}
\RequirePackage{microtype}
\RequirePackage[a4paper,margin=2.2cm,top=2.6cm,bottom=2.4cm]{geometry}
\RequirePackage{xcolor}
\RequirePackage{enumitem}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{mdframed}
\RequirePackage[modulo]{lineno}
\RequirePackage{multicol}
\RequirePackage{array}
\RequirePackage{needspace}

\definecolor{accent}{HTML}{1F4E79}
\definecolor{rep}{HTML}{A23B1E}
\definecolor{notebg}{HTML}{F2F4F7}
\definecolor{noterule}{HTML}{8FA3BA}

%% ---------------------------------------------------------------- en-têtes
\newcommand{\fichenum}{}
\newcommand{\fichetitre}{}
\newcommand{\fichebloc}{}
\newcommand{\metadonnees}[3]{%
  \renewcommand{\fichenum}{#1}\renewcommand{\fichetitre}{#2}%
  \renewcommand{\fichebloc}{#3}}

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
\fancyhead[L]{\footnotesize\sffamily Anglais~--~Seconde\quad Fiche \fichenum}
\fancyhead[R]{\footnotesize\sffamily\ifcorrige\color{rep}Corrigé\else Énoncé\fi}
\fancyfoot[C]{\footnotesize\sffamily\thepage}

\newcommand{\entete}{%
  \thispagestyle{fancy}%
  \begingroup
  \sffamily
  {\color{accent}\rule{\linewidth}{1pt}}\par\vspace{2mm}
  {\footnotesize\color{accent}\MakeUppercase{\fichebloc}}\par\vspace{1mm}
  {\LARGE\bfseries Fiche \fichenum\ --- \fichetitre}\par\vspace{2mm}
  {\color{accent}\rule{\linewidth}{1pt}}
  \endgroup
  \vspace{4mm}\par}

%% ---------------------------------------------------------------- sections
\titleformat{\section}{\sffamily\large\bfseries\color{accent}}{}{0pt}{}
\titlespacing*{\section}{0pt}{5mm}{2mm}

\newcounter{exo}
\newcommand{\exercice}[2][]{%
  \refstepcounter{exo}\needspace{3\baselineskip}%
  \par\vspace{4mm}%
  {\sffamily\bfseries\color{accent}Exercice \theexo\ --- #2}%
  \ifx\relax#1\relax\else{\sffamily\footnotesize\color{accent}\hfill(#1)}\fi
  \par\vspace{1mm}}

\newcommand{\partiel}[2][]{%
  \par\vspace{4mm}%
  {\sffamily\bfseries\color{accent}#2}%
  \ifx\relax#1\relax\else{\sffamily\footnotesize\color{accent}\hfill(#1)}\fi
  \par\vspace{1mm}}

\newcommand{\consigne}[1]{{\itshape #1}\par\vspace{1.5mm}}

%% ---------------------------------------------------------------- réponses
% \trou{réponse} : trait à compléter dans l'énoncé, réponse en couleur dans le corrigé
\newlength{\troulen}
\newcommand{\trou}[1]{%
  \ifcorrige
    \textcolor{rep}{\textbf{#1}}%
  \else
    \settowidth{\troulen}{#1}%
    \ifdim\troulen<2cm \setlength{\troulen}{2cm}\fi
    \addtolength{\troulen}{4mm}%
    \underline{\hspace{\troulen}}%
  \fi}

% \corr{...} : n'apparaît que dans le corrigé
\newcommand{\corr}[1]{\ifcorrige\par\vspace{0.7mm}{\color{rep}#1}\par\vspace{0.7mm}\fi}

% \lignes{n} : lignes à écrire, seulement dans l'énoncé
\newcount\lignecnt
\newcommand{\lignes}[1]{%
  \ifcorrige\else
    \par\vspace{1mm}%
    \lignecnt=#1\relax
    \loop\ifnum\lignecnt>0
      \noindent\rule[-1mm]{\linewidth}{0.2pt}\par\vspace{4.5mm}%
      \advance\lignecnt by -1
    \repeat
    \vspace{1mm}%
  \fi}

% commentaire pédagogique, corrigé seulement
\newmdenv[linewidth=0pt,leftline=true,linecolor=noterule,
  backgroundcolor=notebg,innerleftmargin=3mm,innerrightmargin=3mm,
  innertopmargin=2mm,innerbottommargin=2mm,skipabove=2mm,skipbelow=2mm,
  roundcorner=1pt]{notebox}
% rappel de règle, visible dans l'énoncé comme dans le corrigé
\newmdenv[linewidth=1.2pt,leftline=true,topline=false,bottomline=false,
  rightline=false,linecolor=accent,innerleftmargin=3mm,innerrightmargin=3mm,
  innertopmargin=1.5mm,innerbottommargin=1.5mm,skipabove=2mm,skipbelow=2.5mm]{rappelbox}
\newcommand{\rappel}[1]{\begin{rappelbox}\small #1\end{rappelbox}}

\newcommand{\note}[2][Point de langue]{%
  \ifcorrige
    \begin{notebox}\small\sffamily\textbf{#1.}\ \rmfamily #2\end{notebox}%
  \fi}

%% ---------------------------------------------------------------- textes anglais
\newcommand{\source}[1]{\par\vspace{1mm}\hfill{\footnotesize #1}\par}

% \gl[lemme]{mot}{glose} : mot glosé en note de bas de page
\newcommand{\gl}[3][]{#2\footnote{\foreignlanguage{french}{%
  \emph{\ifx\relax#1\relax #2\else #1\fi} : #3}}}

% \en{...} : passage en anglais (ponctuation et césures anglaises)
\newcommand{\en}[1]{\foreignlanguage{english}{#1}}
\newenvironment{anglais}{\begin{otherlanguage}{english}}{\end{otherlanguage}}

% encadré d'objectifs, en tête de fiche
\newmdenv[linewidth=0.4pt,linecolor=noterule,backgroundcolor=white,
  innerleftmargin=3mm,innerrightmargin=3mm,innertopmargin=2mm,
  innerbottommargin=2mm,skipabove=1mm,skipbelow=3mm]{objbox}
\newcommand{\objectifs}[1]{\begin{objbox}\small #1\end{objbox}}

% texte d'auteur, lignes numérotées de 5 en 5
\newenvironment{texte}{%
  \par\vspace{2mm}\begingroup
  \selectlanguage{english}%
  \small\setlength{\parindent}{1.2em}%
  \leftskip=6mm \rightskip=2mm
  \modulolinenumbers[5]\resetlinenumber\linenumbers
  \renewcommand{\linenumberfont}{\normalfont\tiny\sffamily\color{accent}}%
}{%
  \par\nolinenumbers\endgroup\vspace{2mm}}

\newenvironment{version}{\begin{texte}}{\end{texte}}

\endinput
