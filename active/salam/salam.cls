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
\ProvidesClass{salam}[2022/11/04 A simple article class for maths and physics]

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
  \geometry{top=13mm, bottom=17mm, left=15mm, right=15mm}
  \geometry{includeall}
  \geometry{headheight=7mm, headsep=7mm, footskip=6mm}
  \geometry{marginparwidth=55mm, marginparsep=6mm}

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
\let\@subtiline\relax
\let\@affiliationline\relax
\let\@dateline\relax

\DeclareDocumentCommand{\title}{om}{
  \IfValueTF{#1}{\newcommand{\ushorttitle}{#1}}{\newcommand{\ushorttitle}{#2}}
  \newcommand{\utitle}{#2}
  \newcommand{\@titleline}{{\Large\bfseries\utitle\par}\vspace*{1em}}
}
\DeclareDocumentCommand{\subtitle}{m}{
  \newcommand{\usubtitle}{#1}
  \newcommand{\@subtiline}{{\large\usubtitle\par}}
}
\DeclareDocumentCommand{\author}{m}{
  \newcommand{\uauthor}{#1}
  \newcommand{\@authorline}{\vspace*{1em}{\uauthor\par}}
}
\DeclareDocumentCommand{\affiliation}{m}{
  \newcommand{\uaffiliation}{#1}
  \newcommand{\@affiliationline}{\vspace*{0.5em}{\itshape\uaffiliation\par}}
}
\DeclareDocumentCommand{\date}{m}{
  \newcommand{\udate}{#1}
  \newcommand{\@dateline}{\vspace*{0.5em}{(Dated: #1)\par}}
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

  % Header-Footer style with section heading
  \fancypagestyle{fancy-first}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
  }

  % Header-Footer style with chapter heading
  \fancypagestyle{fancy-general}{
    \fancyhf{}
    \fancyheadoffset[R]{\marginparsep+\marginparwidth}
    \fancyhead[R]{\thepage}
    \fancyhead[L]{\textsl{\ushorttitle}}
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
  {\begin{adjustwidth}{8mm}{8mm}}{\end{adjustwidth}}
\newenvironment{widetext}
  {\begin{adjustwidth}{0mm}{-\marginparwidth-\marginparsep}}{\end{adjustwidth}}

%------------------------------------------------------------
% MAIN TITLE DESIGN & ABSTRACT
%------------------------------------------------------------
\renewcommand{\maketitle}{
  \thispagestyle{fancy-first}
  \begin{minipage}{\textwidth+\marginparwidth+\marginparsep}
    \@titleline
    \@subtiline
    \@authorline
    \@affiliationline
    \@dateline\vspace*{0.7em}
  \end{minipage}\par
}

\renewenvironment{abstract}{}{\vspace*{0.8em}\par}

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
% THE LISTS
%------------------------------------------------------------
\RequirePackage{enumitem}
\setlist[itemize,1]{label=$\bullet$}
\setlist[itemize,2]{leftmargin=6mm}
\setlist[itemize,3]{leftmargin=6mm, label=$\ast$}

%------------------------------------------------------------
% MISC USEFUL BITS
%------------------------------------------------------------
\bibliographystyle{naturemag}
% \bibliographystyle{ieeetr}
% \bibliographystyle{abbrv}
\let\oldfootnote\footnote
\let\openbox\relax

%------------------------------------------------------------
% EXTERNAL MODIFICATIONS
%------------------------------------------------------------
% For highly customisable boxes
\RequirePackage{mdframed}
\newmdenv[hidealllines=true, backgroundcolor=lightgray, skipabove=10pt, skipbelow=10pt, innerleftmargin=8pt, innerrightmargin=8pt, innertopmargin=10pt, innerbottommargin=10pt]{colbox}

%------------------------------------------------------------
% HEADINGS: SECTIONS & SUBSECTIONS
%------------------------------------------------------------
\RequirePackage{titlesec}

\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\arabic{subsection}}
\renewcommand{\thesubsubsection}{\arabic{subsubsection}}


\titleformat{\section}[hang]
  {\large\bfseries}{\thetitle.~}
  {2mm}{}

\titleformat{\subsection}[hang]
  {\bfseries}{\thesection.\thetitle.~}
  {2mm}{}

\titleformat{\subsubsection}[hang]
  {\itshape}{\thesection.\thesubsection.\thetitle.~}
  {2mm}{}

\let\oldappendix\appendix
\renewcommand{\appendix}{
  \oldappendix
  \renewcommand{\thesection}{\Alph{section}}
  \renewcommand{\thesubsection}{\arabic{subsection}}
  \renewcommand{\thesubsubsection}{\arabic{subsubsection}}
  \titleformat{\section}[hang]
  {\large\bfseries}{\appendixname~\thesection .}
  {2mm}{}
  \titleformat{\subsubsection}[hang]
  {\itshape}{\thesection.\thesubsection.\thetitle.~}
  {2mm}{}
}

%------------------------------------------------------------
% TABLE OF CONTENTS
%------------------------------------------------------------
\RequirePackage{titletoc}

\setcounter{tocdepth}{2}
\titlecontents{section}
  [5mm]
  {\large\vspace{3mm}}
  {\thecontentslabel.\hspace*{2mm}}
  {}
  {\titlerule*[2mm]{.}\contentspage}

\titlecontents{subsection}
  [8mm]
  {\large\vspace{3mm}}
  {\thecontentslabel.\hspace*{2mm}}
  {}
  {\titlerule*[2mm]{.}\contentspage}

%------------------------------------------------------------
% BOXES & MARGIN BOXES & SIDENOTES
%------------------------------------------------------------
\RequirePackage{sidenotes}
\RequirePackage{marginnote}
  \renewcommand*{\raggedleftmarginnote}{}
  \renewcommand*{\raggedrightmarginnote}{}
  \DeclareDocumentCommand{\marginbox}{O{lightgray}O{black}m}
    {\marginnote{\begin{colbox}[backgroundcolor=#1]\color{#2}\small#3\end{colbox}}}

%------------------------------------------------------------
% MARGIN TOC
%------------------------------------------------------------
\RequirePackage{etoc}
\newlength{\mtocshift}
\setlength{\mtocshift}{0mm}
\newcommand{\margintoc}[1][\mtocshift]{
  \begingroup
    \etocsettocstyle{}{} % clear default headings
    \etocsetnexttocdepth{section} % show entries down to section level
    \etocsetstyle{section}
      {\parindent -4mm}
      {\leftskip 4mm}
      {\bfseries\small\etocnumber.\hspace*{2mm}\etocname\nobreak\hspace*{2mm}\titlerule*[2mm]{.}\hspace*{2mm}\nobreak\etocpage\par\vspace*{1mm}}
      {}
    \marginnote{\localtableofcontents}[#1] % display the toc
  \endgroup
}

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
\DeclareCaptionStyle{marginfigure}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{sidecaption}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{widefigure}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{margintable}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{widetable}{font=small,labelfont=bf,labelsep=endash}