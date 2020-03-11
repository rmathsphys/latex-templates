%----------------------------------------------------------------------------------------
% GENERAL HANDY PACKAGES (MUST BE LOADED BEFORE THE BASE CLASS)
%----------------------------------------------------------------------------------------
\RequirePackage{etoolbox} % lots of powerful macros
\RequirePackage{xparse} % lots of powerful macros

%----------------------------------------------------------------------------------------
% INITIALIZING & HANDLING CLASS OPTIONS
%----------------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{noether}[2019/12/09 v1.2]

% supported font sizes
\def\@@ptsize{10pt}
\DeclareOption{10pt}{\def\@@ptsize{10pt}} % this is the default option
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}

% 
\DeclareOption*{\PackageWarning{noether}{Unknown: '\CurrentOption'}}
\ProcessOptions\relax

\LoadClass[\@@ptsize]{article} % to be built on top of the article class

%----------------------------------------------------------------------------------------
% CLASS WIDE DOCUMENT INFORMATION COMMANDS
%----------------------------------------------------------------------------------------
\DeclareDocumentCommand{\author}{m}{\newcommand{\uauthor}{#1}}
\DeclareDocumentCommand{\deadline}{m}{\newcommand{\udeadline}{#1}}
\DeclareDocumentCommand{\institute}{m}{\newcommand{\uinstitute}{#1}}
\DeclareDocumentCommand{\moduletitle}{m}{\newcommand{\umoduletitle}{#1}}
\DeclareDocumentCommand{\documenttitle}{m}{\newcommand{\udocumenttitle}{#1}}

%----------------------------------------------------------------------------------------
% STANDARD PAGE LAYOUT
%----------------------------------------------------------------------------------------
\RequirePackage[a4paper]{geometry}
  \geometry{includeall, nomarginpar}
  \geometry{top=10mm, bottom=16mm, left=20mm, right=20mm}
  \geometry{headsep=8mm}

%----------------------------------------------------------------------------------------
% GLOBAL TYPOGRAPHY
%----------------------------------------------------------------------------------------
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{libertine} % main font
\usepackage[libertine]{newtxmath} % closely related maths font
\usepackage{inconsolata} % tt font
\usepackage{microtype}
\usepackage{parskip}
\usepackage{setspace}

%----------------------------------------------------------------------------------------
% COLOURS. A TRADITION.
%----------------------------------------------------------------------------------------
\RequirePackage{xcolor}
  \definecolor{lightgray}{RGB}{211,211,211}
  \definecolor{darkgray}{RGB}{64,64,79}
  \definecolor{gold}{RGB}{255,204,0}
  \definecolor{orange}{RGB}{255,103,0}
  \definecolor{red}{RGB}{255,0,0}
  \definecolor{pink}{RGB}{255,182,193}
  \definecolor{crimson}{RGB}{211,0,63}
  \definecolor{trueblue}{RGB}{0,47,167}
  \definecolor{teal}{RGB}{0,128,128}
  \definecolor{truegreen}{RGB}{0,102,0}

%----------------------------------------------------------------------------------------
% FORMATTING FOR (USUAL) LISTS
%----------------------------------------------------------------------------------------
\RequirePackage[inline]{enumitem}
  \setlist[itemize,1]{label=$\bullet$}
  \setlist[itemize,2]{leftmargin=6mm}
  \setlist[itemize,3]{leftmargin=6mm, label=$\ast$}
  \setlist[enumerate,1]{leftmargin=9mm, labelwidth=5mm, label={(\alph*)}}
  \setlist[enumerate,2]{leftmargin=9mm, labelwidth=5mm, label={\roman*.}}

%----------------------------------------------------------------------------------------
% HEADINGS: SECTIONS & SUBSECTIONS
%----------------------------------------------------------------------------------------
\RequirePackage{titlesec}
  \titleformat{\section}{\large\sffamily\bfseries\centering}{}{0.5em}{}
  \titleformat{\subsection}{\large\itshape\centering}{}{0.5em}{}

%----------------------------------------------------------------------------------------
% THE BOX (FOR USER)
%----------------------------------------------------------------------------------------
\RequirePackage{mdframed} % for highly customisable boxes
\newmdenv[hidealllines=true, backgroundcolor=lightgray, skipabove=10pt,
  skipbelow=10pt, innerleftmargin=8pt, innerrightmargin=8pt, innertopmargin=10pt,
  innerbottommargin=10pt]{colbox}

%----------------------------------------------------------------------------------------
% SOME AUXILIARY COMMANDS (FOR USER)
%----------------------------------------------------------------------------------------
\DeclareDocumentCommand{\totalmarks}{m}{\hfill\textbf{[#1]}\par}
\DeclareDocumentCommand{\hint}{m}{{\itshape [HINT: #1]}}

%----------------------------------------------------------------------------------------
% STYLES FOR TYPESETTING ADMINISTRATIVE ELEMENTS. MULTIPLE STYLES.
%----------------------------------------------------------------------------------------

\RequirePackage{noether-variations}

%----------------------------------------------------------------------------------------
% STYLES FOR TYPESETTING QUESTIONS. MULTIPLE STYLES.
%----------------------------------------------------------------------------------------
\RequirePackage{noether-questions}

%----------------------------------------------------------------------------------------
% INITIALIZE THE ACTUAL ENVIRONMENTS AND COMMANDS (FOR USER)
%----------------------------------------------------------------------------------------
\renewcommand{\maketitle}{\@@selectedtitle}
\newenvironment{rubric}{\@@selectedrubricstart}{\@@selectedrubricend}
\newenvironment{signature}{\@@selectedsignaturestart}{\@@selectedsignatureend}
