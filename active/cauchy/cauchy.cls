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
\ProvidesClass{cauchy}[2022/12/20 A simple article class for maths and physics thesis]

\def\@@ptsize{11pt}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}} % the default option
\DeclareOption{12pt}{\def\@@ptsize{12pt}}

\DeclareOption*{\PackageWarning{cauchy}{Unknown: '\CurrentOption'}}
\ProcessOptions\relax

\LoadClass[\@@ptsize]{article} % to be built on top of the article class

%------------------------------------------------------------
% STANDARD PAGE LAYOUTS
%------------------------------------------------------------
\RequirePackage[a4paper]{geometry}
  \geometry{nomarginpar}
  \geometry{includeall}
  \geometry{top=14mm, bottom=22mm, left=29mm, right=29mm}
  \geometry{headheight=7mm, headsep=6mm, footskip=9mm}

%------------------------------------------------------------
% GLOBAL TYPOGRAPHY
%------------------------------------------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{inconsolata}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage{microtype}

%------------------------------------------------------------
% CLASS WIDE COMMON SETUP: DOCUMENT INFORMATION COMMANDS
%------------------------------------------------------------
\DeclareDocumentCommand{\title}{om}{
  \IfValueTF{#1}{\newcommand{\ushorttitle}{#1}}{\newcommand{\ushorttitle}{#2}}
  \newcommand{\utitle}{#2}
}
\DeclareDocumentCommand{\subtitle}{m}{
  \newcommand{\usubtitle}{#1}
}
\DeclareDocumentCommand{\author}{m}{
  \newcommand{\uauthor}{#1}
}
\DeclareDocumentCommand{\affiliation}{m}{
  \newcommand{\uaffiliation}{#1}
}
\DeclareDocumentCommand{\date}{m}{
  \newcommand{\udate}{#1}
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

  \renewcommand{\sectionmark}[1]{\markright{{#1}}}
  \renewcommand{\subsectionmark}[1]{}
  
  % Header-Footer style for the blank page
  \fancypagestyle{fancy-blank}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
  }

  % Header-Footer style for the frontmatter pages
  \fancypagestyle{fancy-front}{
    \fancyhf{}
    \fancyfoot[C]{-- \thepage\ --}
    \renewcommand{\headrulewidth}{0pt}
  }

  % Header-Footer style with chapter heading
  \fancypagestyle{fancy-general}{
    \fancyhf{}
    \fancyhead[C]{\rightmark}
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
  {\begin{adjustwidth}{20mm}{20mm}}{\end{adjustwidth}}
\newenvironment{widetext}
  {\begin{adjustwidth}{-12mm}{-12mm}}{\end{adjustwidth}}

%------------------------------------------------------------
% MAIN TITLE DESIGN & ABSTRACT
%------------------------------------------------------------
\renewcommand{\maketitle}{}

\renewenvironment{abstract}
  {\begin{adjustwidth}{10mm}{10mm}}
  {\vspace*{0.5em}\end{adjustwidth}}

%------------------------------------------------------------
% HEADINGS: SECTIONS & SUBSECTIONS
%------------------------------------------------------------
\RequirePackage{titlesec}
\newcommand{\sectionbreak}{\clearpage}

\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\arabic{section}.\arabic{subsection}.\arabic{subsubsection}}

\newcommand\chaptername{Chapter}
\titleformat{\section}[display]
  {\thispagestyle{fancy-front}\vspace*{9mm}\normalfont\Large\bfseries}
  {\chaptername~\thetitle}
  {12mm}
  {\huge}

\titlespacing*{\section}{0mm}{0mm}{30mm}

\titleformat{\subsection}[hang]
  {\Large\bfseries}{\thetitle~}
  {2mm}{}

\titleformat{\subsubsection}[hang]
  {\large\itshape}{\thetitle~}
  {2mm}{}

\let\oldappendix\appendix
\renewcommand{\appendix}{
  \oldappendix
  \let\chaptername\appendixname
}

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
\bibliographystyle{elsarticle-num}
\renewcommand{\refname}{Bibliography}
\let\openbox\relax

\newcommand{\frontmatter}{
\pagestyle{fancy-front}
\pagenumbering{roman}}

\newcommand{\mainmatter}{
\setcounter{page}{1}
\pagestyle{fancy-general}
\pagenumbering{arabic}
\clearpage}

\newcommand{\backmatter}{
\pagestyle{fancy-blank}
\clearpage}

% \onehalfspacing
\setstretch{1.15}

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

%------------------------------------------------------------
% TABLE OF CONTENTS
%------------------------------------------------------------
\RequirePackage{etoc}
\etocsettocdepth{subsection}
\etocsettocstyle{\section*{\contentsname}\par\nobreak}{}

% \newcommand \Dotfill {\leavevmode \cleaders \hb@xt@ .44em{\hss .\hss }\hfill \kern \z@}

% \etocsetstyle{section}
% {}
% {\vspace*{0.8em}\leavevmode\leftskip 0cm\relax}
% {\bfseries\normalsize\etocifnumbered{\makebox[7mm][l]{\etoclink{\etocthenumber.}}}{}%
% \etocname\nobreak\hfill\nobreak%
% \makebox[8mm][r]{\mdseries\etocpage}\par\vspace*{0.4em}}
% {}

% \etocsetstyle{subsection}
% {}
% {\leavevmode\leftskip 7mm\relax}
% {\mdseries\normalsize\makebox[12mm][l]{\etoclink{\etocthenumber.}}%
% \etocname\nobreak\hspace*{2mm}\nobreak\Dotfill\nobreak%
% \makebox[8mm][r]{\etocpage}\par\vspace*{0.4em}}
% {}
