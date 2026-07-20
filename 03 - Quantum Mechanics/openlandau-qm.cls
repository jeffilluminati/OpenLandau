\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{openlandau-qm}[2026/07/10 OpenLandau compact scholarly textbook]

\LoadClass[10pt,twoside,openright]{book}

% Unaudited fragments remain inert in focused/release wrappers.  The complete
% working proof explicitly enables them and labels itself provisional.
\newif\ifOpenLandauFullDraft
\OpenLandauFullDraftfalse
\newcommand{\ProvisionalInput}[1]{%
  \ifOpenLandauFullDraft\InputIfFileExists{#1}{}{}\fi}

\RequirePackage[
  paperwidth=155mm,
  paperheight=235mm,
  inner=18mm,
  outer=15mm,
  top=17mm,
  bottom=20mm,
  headheight=12pt,
  headsep=5mm,
  footskip=10mm
]{geometry}
\RequirePackage[10pt]{type1ec}
\RequirePackage[T2A,T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\DeclareFontFamilySubstitution{T2A}{ntxtlf}{cmr}
\RequirePackage{mathtools}
\RequirePackage{amsthm}
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage[scaled=0.92]{helvet}
\DeclareFontFamily{T2A}{phv}{}
\DeclareFontShape{T2A}{phv}{m}{n}{<->ssub*cmss/m/n}{}
\DeclareFontShape{T2A}{phv}{b}{n}{<->ssub*cmss/bx/n}{}
\RequirePackage[russian,english]{babel}
\RequirePackage{microtype}
\RequirePackage{booktabs}
\RequirePackage[font=small,labelfont={bf,sf},labelsep=period]{caption}
\RequirePackage{enumitem}
\RequirePackage{needspace}
\RequirePackage{chngcntr}
\RequirePackage{physics}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{emptypage}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,calc,decorations.markings,decorations.pathreplacing,patterns}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
\RequirePackage{xcolor}
\definecolor{SpringerBlue}{RGB}{0,71,187}
\definecolor{ShadeBg}{RGB}{240,240,240}
\definecolor{fixedC}{RGB}{0,115,200}
\definecolor{bodyC}{RGB}{227,25,35}
\definecolor{nodeC}{RGB}{0,150,70}
\RequirePackage[
  unicode,
  pdfencoding=auto,
  psdextra,
  pdfpagelabels,
  bookmarksnumbered,
  bookmarksopen,
  bookmarksopenlevel=1,
  hypertexnames=false,
  colorlinks,
  linkcolor=SpringerBlue,
  citecolor=SpringerBlue,
  urlcolor=SpringerBlue,
  filecolor=SpringerBlue
]{hyperref}
\hypersetup{
  pdftitle={Quantum Mechanics: Non-relativistic Theory},
  pdfauthor={L. D. Landau and E. M. Lifshitz},
  pdfsubject={Course of Theoretical Physics, Volume III},
  pdfcreator={OpenLandau LaTeX workflow}
}

\RequirePackage{tcolorbox}
\tcbuselibrary{theorems,breakable,skins}

\newtcbtheorem[number within=section]{theorem}{Theorem}{%
  enhanced,
  breakable,
  colback=ShadeBg,
  colframe=ShadeBg,
  coltitle=black,
  fonttitle=\sffamily\bfseries,
  separator sign={.},
  description font=\normalfont\itshape,
  boxrule=0pt,
  arc=2pt,
  left=6pt, right=6pt, top=6pt, bottom=6pt,
  before skip=8pt plus 2pt,
  after skip=8pt plus 2pt
}{thm}

\newtcbtheorem[number within=section]{axiom}{Axiom}{%
  enhanced,
  breakable,
  colback=ShadeBg,
  colframe=ShadeBg,
  coltitle=black,
  fonttitle=\sffamily\bfseries,
  separator sign={.},
  description font=\normalfont\itshape,
  boxrule=0pt,
  arc=2pt,
  left=6pt, right=6pt, top=6pt, bottom=6pt,
  before skip=8pt plus 2pt,
  after skip=8pt plus 2pt
}{ax}

\newtcbtheorem[number within=section]{definition}{Definition}{%
  enhanced,
  breakable,
  colback=white,
  colframe=black,
  coltitle=black,
  fonttitle=\sffamily\bfseries,
  separator sign={.},
  description font=\normalfont\itshape,
  boxrule=0.5pt,
  arc=2pt,
  left=6pt, right=6pt, top=6pt, bottom=6pt,
  before skip=8pt plus 2pt,
  after skip=8pt plus 2pt
}{def}

\newcommand{\VolumeTitle}{Quantum Mechanics}
\newcount\OpenLandauSourcePage
\OpenLandauSourcePage=-1
\newcommand{\SourcePage}[2]{%
  \global\OpenLandauSourcePage=#1\relax
  \ifhmode\space\fi
  \ignorespaces
}
\newcommand{\SourcePageJoin}[2]{%
  \global\OpenLandauSourcePage=#1\relax
  \ignorespaces
}
\newcommand{\TranscriptionUnclear}[1]{\textbf{[UNCLEAR: #1]}}
\providecommand{\Tr}{\operatorname{Tr}}
\newcommand{\Grad}[1]{\nabla #1}
\newcommand{\Div}[1]{\nabla\!\cdot #1}
\newcommand{\Curl}[1]{\nabla\!\times #1}
\newcommand{\GradAt}[2]{\nabla_{#1} #2}
\newcommand{\DivAt}[2]{\nabla_{#1}\!\cdot #2}
\newcommand{\CurlAt}[2]{\nabla_{#1}\!\times #2}
\newcommand{\ProblemHeading}{%
  \par\Needspace{6\baselineskip}\medskip
  \begin{center}\normalfont\scshape Problem\end{center}%
  \nopagebreak
}
\newcommand{\SolutionHeading}{%
  \par\smallskip\noindent\textsc{Solution}.\enspace\ignorespaces
}
\renewcommand{\thefootnote}{\arabic{footnote}}

\renewcommand{\thechapter}{\Roman{chapter}}
\counterwithout{section}{chapter}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\renewcommand{\thesection}{\arabic{section}}
\setcounter{secnumdepth}{1}
\titleformat{\chapter}[display]
  {\normalfont\sffamily}
  {\large\bfseries\MakeUppercase{\iflanguage{russian}{Глава}{Chapter}}\enspace\thechapter}
  {1ex}
  {\titlerule[0.5pt]\vspace{1.4ex}\LARGE\bfseries}
\titlespacing*{\chapter}{0pt}{0pt}{3.5ex}
\titleformat{\section}
  {\normalfont\sffamily\large\bfseries}
  {\S\,\thesection.}
  {0.6em}
  {}[\label{sec:\thesection}]
\titleformat{name=\section,numberless}
  {\normalfont\sffamily\large\bfseries}
  {}
  {0pt}
  {}
\makeatletter
\newcommand{\OpenLandauSectionLink}[1]{%
  \@ifundefined{r@sec:#1}{#1}{\hyperref[sec:#1]{#1}}% 
}
\newcommand{\secref}[1]{\S\,\OpenLandauSectionLink{#1}}
\newcommand{\secsref}[2]{%
  \S\S\,\OpenLandauSectionLink{#1}--\OpenLandauSectionLink{#2}%
}
\makeatother
\titlespacing*{\section}{0pt}{3ex plus .8ex minus .2ex}{1.2ex}

\renewcommand{\cftchapfont}{\sffamily\bfseries}
\renewcommand{\cftchappagefont}{\sffamily\bfseries}
\renewcommand{\cftsecfont}{\normalfont}
\renewcommand{\cftsecpagefont}{\sffamily\small}
\setlength{\cftbeforechapskip}{0.8em}
\setlength{\cftbeforesecskip}{0.15em}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{\sffamily\small\thepage}
\fancyhead[CE]{\sffamily\footnotesize\MakeUppercase{\leftmark}}
\fancyhead[CO]{\sffamily\footnotesize\MakeUppercase{\rightmark}}
\renewcommand{\headrulewidth}{0.35pt}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\S\,\thesection. #1}}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
}

\linespread{1.05}
\setlength{\parindent}{1.6em}
\setlength{\parskip}{0pt}
\setlength{\abovedisplayskip}{7pt plus 2pt minus 2pt}
\setlength{\belowdisplayskip}{7pt plus 2pt minus 2pt}
\setlength{\abovedisplayshortskip}{4pt plus 2pt}
\setlength{\belowdisplayshortskip}{5pt plus 2pt minus 1pt}
\emergencystretch=1.5em
