%------------------------------------------------------------
% GENERAL HANDY PACKAGES (MUST BE LOADED BEFORE THE BASE CLASS)
%------------------------------------------------------------
\RequirePackage{etoolbox} % lots of powerful macros
\RequirePackage{xparse} % lots of powerful macros
\RequirePackage{calc} % for various calculations

%------------------------------------------------------------
% INITIALIZING & HANDLING CLASS OPTIONS
%------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{penrose}[2023/12/29 A simple article class for maths and physics]

\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{article}} %default (in the article cls)
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{final}{\PassOptionsToClass{\CurrentOption}{article}}

\DeclareOption*{\PackageWarning{penrose}{Unknown: '\CurrentOption'}}
\ProcessOptions\relax

\LoadClass{article} % built on top of the article class

%------------------------------------------------------------
% STANDARD PAGE LAYOUTS
%------------------------------------------------------------
\RequirePackage[a4paper]{geometry}
  \geometry{nomarginpar}
  \geometry{includeall}
  \geometry{top=16mm, bottom=22mm, left=31mm, right=31mm}
  \geometry{headheight=7mm, headsep=6mm, footskip=8mm}

%------------------------------------------------------------
% GLOBAL TYPOGRAPHY
%------------------------------------------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage{microtype}

%------------------------------------------------------------
% CLASS WIDE COMMON SETUP: DOCUMENT INFORMATION COMMANDS
%------------------------------------------------------------
\let\@subtiline\relax
\let\@affiliationline\relax
\let\@dateline\relax

\DeclareDocumentCommand{\title}{om}{
  \IfValueTF{#1}{\newcommand{\ushorttitle}{#1}}{\newcommand{\ushorttitle}{#2}}
  \newcommand{\utitle}{#2}
  \newcommand{\@titleline}{{\Large\bfseries\utitle\par}\vspace*{0.2em}}
}
\DeclareDocumentCommand{\subtitle}{m}{
  \newcommand{\usubtitle}{#1}
  \newcommand{\@subtiline}{{\large\usubtitle\par}}
}
\DeclareDocumentCommand{\author}{m}{
  \newcommand{\uauthor}{#1}
  \newcommand{\@authorline}{\vspace*{0.7em}{\uauthor\par}}
}
\DeclareDocumentCommand{\affiliation}{m}{
  \newcommand{\uaffiliation}{#1}
  \newcommand{\@affiliationline}{{\itshape\uaffiliation\par}}
}
\DeclareDocumentCommand{\date}{m}{
  \newcommand{\udate}{#1}
  \newcommand{\@dateline}{{(Date: #1)\par}}
}

%------------------------------------------------------------
% COLOURS
%------------------------------------------------------------
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

%------------------------------------------------------------
% HEADER & FOOTER
%------------------------------------------------------------
\RequirePackage{fancyhdr}
  \pagestyle{fancy}
  
  % Header-Footer style for the first page
  \fancypagestyle{fancy-first}{
    \fancyhf{}
    \fancyfoot[C]{-- \thepage\ --}
    \renewcommand{\headrulewidth}{0pt}
  }

  % Header-Footer style with chapter heading
  \fancypagestyle{fancy-general}{
    \fancyhf{}
    \fancyhead[C]{{\slshape\ushorttitle}}
    \fancyfoot[C]{-- \thepage\ --}
    \renewcommand{\headrulewidth}{0pt}
  }

% Activating the default header-footer style
\pagestyle{fancy-general}

%------------------------------------------------------------
% GLOBAL SNIPPETS
%------------------------------------------------------------
\RequirePackage[strict]{changepage}

\DeclareDocumentCommand{\newthought}{m}{{\scshape#1}}

\renewenvironment{quote}
  {\begin{adjustwidth}{10mm}{10mm}}{\end{adjustwidth}}
\newenvironment{widetext}
  {\begin{adjustwidth}{-15mm}{-15mm}}{\end{adjustwidth}}

%------------------------------------------------------------
% MAIN TITLE DESIGN & ABSTRACT
%------------------------------------------------------------
\renewcommand{\maketitle}{
  \begingroup
  \thispagestyle{fancy-first}
  \begin{adjustwidth}{-15mm}{-15mm}
    \centering
    \@titleline
    \@subtiline
    \@authorline
    \@affiliationline
    \@dateline\vspace*{0.5em}
  \end{adjustwidth}
  \endgroup
}

\renewenvironment{abstract}
  {\begin{adjustwidth}{10mm}{10mm}}
  {\vspace*{0.5em}\end{adjustwidth}}

%------------------------------------------------------------
% HYPERLINKS
%------------------------------------------------------------
\RequirePackage{hyperref}
  \hypersetup{
    colorlinks=true,
    linktoc=all,
    citecolor=crimson,
    linkcolor=teal,
    filecolor=teal,
    urlcolor=teal
  }

%------------------------------------------------------------
% MISC USEFUL BITS
%------------------------------------------------------------
\bibliographystyle{naturemag}
\usepackage[square,numbers,comma,sort&compress]{natbib}
\let\openbox\relax

%------------------------------------------------------------
% EXTERNAL MODIFICATIONS
%------------------------------------------------------------
% For highly customisable boxes
\RequirePackage{mdframed}
\newmdenv[hidealllines=true, backgroundcolor=lightgray, skipabove=10pt, skipbelow=10pt, innerleftmargin=8pt, innerrightmargin=8pt, innertopmargin=10pt, innerbottommargin=10pt]{colbox}

%------------------------------------------------------------
% THE LISTS
%------------------------------------------------------------
\RequirePackage{enumitem}
\setlist[itemize,1]{label=$\bullet$}
\setlist[itemize,2]{leftmargin=6mm}
\setlist[itemize,3]{leftmargin=6mm, label=$\ast$}

%------------------------------------------------------------
% TABLES
%------------------------------------------------------------
\usepackage{booktabs,tabularx}
\newcolumntype{C}{>{\centering\arraybackslash}X}
\newcolumntype{L}{>{\raggedright\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}
\newcolumntype{D}[1]{>{\centering\arraybackslash}p{#1}}
\newcommand{\ra}[1]{\renewcommand{\arraystretch}{#1}}

%------------------------------------------------------------
% CAPTIONS
%------------------------------------------------------------
\RequirePackage[font=small,labelfont=bf,labelsep=endash]{caption}
\DeclareCaptionStyle{widefigure}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{margintable}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{widetable}{font=small,labelfont=bf,labelsep=endash}

\DeclareCaptionStyle{marginfigure}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{sidecaption}{font=small,labelfont=bf,labelsep=endash}

%------------------------------------------------------------
% FOR MORE COMPATABILITY WITH SALAM.CLS
%------------------------------------------------------------
\RequirePackage{sidenotes}
\let\sidenote\footnote
\let\margintoc\relax
\DeclareDocumentCommand{\marginbox}{oom}{}
\DeclareDocumentCommand{\marginnote}{omo}{}
