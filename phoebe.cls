% phoebe.cls
%
% Phoebe Gazette document class file
%
% This is a draft version

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{phoebe}[2024/07/05 Phoebe Class]

\LoadClass[%
    paper        = a4,
    fontsize.    = 10pt,
    twoside      = true,
    twocolumn    = true,
    bibliography = leveldown,  % no pagebreak before bibliography
    numbers      = noenddot,   % no period after numbers (2.1.)
]{scrartcl}


% ------------------------------------------------------------
% Basics
% ------------------------------------------------------------

% encoding
\RequirePackage[utf8]{luainputenc}
\RequirePackage{fontspec}

% font
\setmainfont{Libertinus Serif}
\setsansfont[%
    UprightFont = *-Light,
    BoldFont = *-Medium,
    ItalicFont = *-Italic,
    BoldItalicFont = *-BoldItalic
]{FiraSans}
\setmonofont[Scale=0.9]{Fira Code}

\RequirePackage{pgfkeys}
\RequirePackage{pgfopts}

\newcommand*\phoebe@language{ngerman}

\pgfkeys{
    phoebe/.cd,
    language/.code    = \renewcommand*\phoebe@language{#1},
    language/.default = ngerman
}
\ProcessPgfOptions{/phoebe}

% language
\RequirePackage[\phoebe@language]{babel}

% quotation marks
\RequirePackage[german=guillemets]{csquotes}
\RequirePackage{hyphenat}

% footnotes
\RequirePackage[bottom,hang]{footmisc}
\setlength{\footnotemargin}{2mm} % position of footnote mark relative to the start of the line in which they appear
\skip\footins=15pt\relax
\footnotesep=10pt\relax

% geometry
\RequirePackage{geometry}
\geometry{
    left   = 15mm,
    right  = 15mm,
    top    = 25mm,
    bottom = 25mm
}

% column gap
\RequirePackage{setspace}
\setlength{\columnsep}{1.5em}

% flushed right
\RequirePackage{ragged2e}

% ------------------------------------------------------------
% Title
% ------------------------------------------------------------

\RequirePackage{xstring}
\newcommand{\keywordsname}[1]{%
    \IfEqCase{#1}{%
        {ngerman}{Stichwörter}%
        {english}{Keywords}%
    }[\PackageError{keywordsname}{Undefined option to keywordsname: #1}{}]%
}%

\newcommand\email[1]{\renewcommand\@email{#1}}
\newcommand\@email{}

\newcommand\keywords[1]{\renewcommand\@keywords{#1}}
\newcommand\@keywords{}

\newcommand\doi[1]{\renewcommand\@doi{#1}}
\newcommand\@doi{}

\renewcommand\abstract[1]{\renewcommand\@newabstract{#1}}
\newcommand\@newabstract

\renewcommand*{\@maketitle}{%
\vskip20pt%
    {\raggedright\sffamily\bfseries\fontsize{20}{25}\selectfont \@title\par}
    \vskip10pt
    {\raggedright\sffamily\fontsize{12}{16}\selectfont \@author\par}
    \vskip3pt
    {\raggedright\sffamily\fontsize{12}{16}\selectfont \@date\par}
    \vskip18pt
    {\onehalfspacing\sffamily\textbf{\abstractname.} \@newabstract\par}
    \vskip3pt
    {\onehalfspacing\footnotesize\sffamily\textbf{Email:} \ttfamily\href{mailto:\@email}{\@email}\par}
    \vskip3pt
    {\onehalfspacing\footnotesize\sffamily\textbf{\keywordsname{\phoebe@language}:} \@keywords\par}
    \vskip20pt
}


% ------------------------------------------------------------
% Header and Footer
% ------------------------------------------------------------

\usepackage{scrlayer-scrpage}
\pagestyle{scrheadings}
\clearpairofpagestyles
\setkomafont{pageheadfoot}{\sffamily}
\setkomafont{pagination}{}
\clearpairofpagestyles
\lehead{\small\@author}
\rohead{\small\@title}
\rofoot[{\scriptsize Phoebe $\cdot$ Gazette für Studentische Forschung}\quad{\bfseries\pagemark}]{{\scriptsize Phoebe $\cdot$ Gazette für Studentische Forschung}\quad{\bfseries\pagemark}}
\lefoot[{\bfseries\pagemark}\quad{\scriptsize Phoebe $\cdot$ Gazette für Studentische Forschung}]{{\bfseries\pagemark}\quad{\scriptsize Phoebe $\cdot$ Gazette für Studentische Forschung}}


% ------------------------------------------------------------
% Headings: section, subsection
% ------------------------------------------------------------

\setkomafont{section}{\sffamily\bfseries}
\setkomafont{subsection}{\small\sffamily\bfseries}


% ------------------------------------------------------------
% Various packages for math, floats, etc.
% ------------------------------------------------------------

% math
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{amsthm}

% Page breaks in equations
\allowdisplaybreaks

% math font
\RequirePackage[%
  math-style = TeX,
  bold-style = ISO,
  nabla      = upright,
  partial    = upright,
]{unicode-math}
\setmathfont{Libertinus Math}

% balance the columns on the last page
% \RequirePackage{flushend}
\RequirePackage{cuted}

% wide equations, requires `flushed` an `cuted` packages
\newlength\@parindent
\setlength\@parindent{\parindent}
\newenvironment{widetext} {%
    \begin{strip}
    \rule{\dimexpr(0.5\textwidth-0.5\columnsep-0.4pt)}{0.4pt}%
    \rule{0.4pt}{6pt}
    \par %\vspace{6pt}
    \parindent \@parindent
}%
{%
    \par
    \hfill\rule[-6pt]{0.4pt}{6.4pt}%
    \rule{\dimexpr(0.5\textwidth-0.5\columnsep-1pt)}{0.4pt}
    \end{strip}
}

% units
\RequirePackage{siunitx}

\sisetup{%
    per-mode                = reciprocal,
    exponent-base           = 10,
    exponent-product        = \cdot,
    group-digits            = true,
    group-separator         = {\,},
    group-minimum-digits    = 5,
    inter-unit-product      = {\;},
    parse-numbers           = true, 
    range-units             = single,
    separate-uncertainty    = true,
    input-uncertainty-signs = \pm,
    uncertainty-separator   = {\,}, 
    multi-part-units        = single,
}

% pictures
\RequirePackage{graphicx}
\graphicspath{{assets/}{./}} % specifies where to look for included images (trailing slash required)

% corporate design colors of Heidelberg University
\RequirePackage{xcolor}
\definecolor{uhdred}{RGB}{197, 13, 41}
\definecolor{darkred}{RGB}{90, 15, 20}
\definecolor{sand}{RGB}{245, 240, 234}
\definecolor{linkblue}{RGB}{78, 121, 167}
\definecolor{citegreen}{RGB}{89, 161, 78}
\definecolor{refred}{RGB}{225, 87, 89}

\definecolor{lstbackground}{RGB}{247, 248, 250}

% source code
\RequirePackage{listings}
 
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\lstdefinestyle{phoebestyle}{%
    language          = [LaTeX]TeX,
    backgroundcolor   = \color{lstbackground},
    commentstyle      = \color{citegreen},
    keywordstyle      = \color{uhdred},
    numberstyle       = \tiny\color{codegray},
    stringstyle       = \color{codepurple},
    basicstyle        = \ttfamily\footnotesize,
    breakatwhitespace = false,
    breaklines        = true,
    captionpos        = b,
    keepspaces        = true,
    showspaces        = false,
    showstringspaces  = false,
    showtabs          = false,                  
    tabsize           = 2,
    frame             = single,
    framesep          = 5pt,
    framerule         = 0pt,
    xleftmargin       = 5pt,
    xrightmargin      = 5pt,
    columns           = fullflexible
}

\lstset{style=phoebestyle}

% ------------------------------------------------------------
% Figures and Tables
% ------------------------------------------------------------

% tables
\RequirePackage{%
    booktabs,
    multirow,
    array
}
\RequirePackage{tabularx}

% captions
\RequirePackage[%
    labelfont     = {bf,sf,small},
    labelsep      = period,
    justification = raggedright,
]{caption}

\newcommand{\figurecaptionname}[1]{%
    \IfEqCase{#1}{%
        {ngerman}{Abb.}%
        {english}{Fig.}%
    }[\PackageError{figurecaptionname}{Undefined option to figurecaptionname: #1}{}]%
}%

\captionsetup[figure]{%
    name      = {\sffamily\bfseries\figurecaptionname{\phoebe@language}},
    font      = small,
    labelfont = bf,
    textfont  = it
}

\captionsetup[subfigure]{labelformat=empty}

\captionsetup[table]{%
    name      = {\sffamily\bfseries Tab.},
    font      = small,
    labelfont = bf,
    textfont  = it
}

\setlength{\abovecaptionskip}{3pt}
\setlength{\belowcaptionskip}{0pt}


% ------------------------------------------------------------
% Bibliography
% ------------------------------------------------------------

\RequirePackage[
    backend  = biber,
    style    = authoryear-comp,
    hyperref = true,
    natbib   = true
]{biblatex}

\RequirePackage[
    colorlinks,
    pdfpagelabels,
    pdfstartview      = FitH,
    bookmarksopen     = true,
    bookmarksnumbered = true,
    linkcolor         = black,
    plainpages        = false,
    hypertexnames     = false,
    citecolor         = black,
    urlcolor          = blue,
]{hyperref}

\urlstyle{rm}
