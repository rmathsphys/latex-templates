%------------------------------------------------------------
% GENERAL HANDY PACKAGES (MUST BE LOADED AFTER THE BASE CLASS)
%------------------------------------------------------------
\RequirePackage{etoolbox} % lots of powerful macros
\RequirePackage{xparse} % lots of powerful macros
\RequirePackage{calc} % for various calculations

%------------------------------------------------------------
% INITIALIZING & HANDLING CLASS OPTIONS
%------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{witten}[2021/07/02]

\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{article}} %default (in the article cls)
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{final}{\PassOptionsToClass{\CurrentOption}{article}}

\DeclareOption*{\PackageWarning{penrose}{Unknown: '\CurrentOption'}}
\ProcessOptions\relax

\LoadClass[a4paper,landscape,twocolumn,oneside]{book} % to be built on top of the book class

%------------------------------------------------------------
% DOCUMENT INFORMATION COMMANDS
%------------------------------------------------------------
\DeclareDocumentCommand{\date}{m}{\newcommand{\udate}{#1}\renewcommand{\@date}{#1}}
\DeclareDocumentCommand{\title}{m}{\newcommand{\utitle}{#1}\renewcommand{\@title}{#1}}
\DeclareDocumentCommand{\title}{om}{\newcommand{\ushorttitle}{#1}\newcommand{\utitle}{#2}\renewcommand{\@title}{#2}}
\DeclareDocumentCommand{\author}{m}{\newcommand{\uauthor}{#1}\renewcommand{\@author}{#1}}
\DeclareDocumentCommand{\affiliation}{m}{\newcommand{\uaffiliation}{#1}}
\DeclareDocumentCommand{\isbn}{m}{\newcommand{\uisbn}{#1}}
\DeclareDocumentCommand{\publisher}{m}{\newcommand{\upublisher}{#1}}
\DeclareDocumentCommand{\edition}{m}{\newcommand{\uedition}{#1}}
\DeclareDocumentCommand{\volume}{m}{\newcommand{\uvolume}{#1}}
\DeclareDocumentCommand{\revision}{m}{\newcommand{\urevision}{#1}}
\DeclareDocumentCommand{\website}{m}{\newcommand{\uwebsite}{#1}}

%------------------------------------------------------------
% GLOBAL TYPOGRAPHY
%------------------------------------------------------------
\RequirePackage{lmodern}
\RequirePackage{microtype}
\RequirePackage{parskip}
\RequirePackage{changepage}

\RequirePackage[defaultsans, scale=0.9]{lato}

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
% STANDARD PAGE LAYOUTS
%------------------------------------------------------------
\RequirePackage{geometry}

% The default page layout:
\geometry{includeall, nomarginpar, top=14mm, bottom=12mm, left=20mm, right=20mm, headheight=16pt, columnsep=17mm}

\let\oldcleardoublepage\cleardoublepage
\renewcommand*{\cleardoublepage}{\clearpage}

%------------------------------------------------------------
% HEADERS & FOOTERS
%------------------------------------------------------------
\RequirePackage{fancyhdr}
  \pagestyle{fancy}
  \renewcommand{\chaptermark}[1]{\markboth{#1}{}}
  \renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
  
  % Header-Footer style for standard (chapter) pages
  \fancypagestyle{fancy-chapter}{
    \fancyhf{}
    \fancyhead[L]{\textsl{\leftmark}}
    \fancyhead[R]{\thepage}
    \renewcommand{\headrulewidth}{0pt}
  }

  % Header-Footer style showing only page numbers
  \fancypagestyle{fancy-pagenum}{
    \fancyhf{}
    \fancyhead[R]{\thepage}
    \renewcommand{\headrulewidth}{0pt}
  }

  % Redefining the 'plain' header-footer style to be empty
  \fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt} 
  }

% Activating the default header-footer style
\pagestyle{plain}

%------------------------------------------------------------
% HYPERLINKS & BOOKMARKS
%------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{
  linktoc=all,
  colorlinks=true,
  citecolor=crimson,
  linkcolor=trueblue,
  filecolor=teal,
  urlcolor=teal,
}
\RequirePackage{bookmark} % for bookmarks in the PDF

%------------------------------------------------------------
% FRONT-, MAIN-, BACK- MATTERS BEHAVIOUR
%------------------------------------------------------------
% Front matter
\let\oldfrontmatter\frontmatter % Store the old command
\renewcommand{\frontmatter}{
  \oldfrontmatter % First of all, call the old command
  \pagestyle{plain}
}

% Main matter
\let\oldmainmatter\mainmatter % Store the old command
\renewcommand{\mainmatter}{
  \oldmainmatter % Call the old command
  \pagestyle{fancy-chapter}
  \def\@@chapterlable{\uchapterlabel}
}

% Appendix
\let\oldappendix\appendix % Store the old command
\renewcommand{\appendix}{
  \oldappendix % Call the old command
  \def\@@chapterlable{Appendix}
}

% Back matter
\let\oldbackmatter\backmatter % Store the old command
\renewcommand{\backmatter}{
  \oldbackmatter % Call the old command
  \bookmarksetup{startatroot} % Reset the bookmark depth
  \pagestyle{fancy-pagenum}
  \let\@@chapterclear\newpage
}

%------------------------------------------------------------
% HEADINGS: PART, CHAPTER, SECTION, SUBSECTION
%------------------------------------------------------------
\RequirePackage{titlesec}

% Default style for parts
\titleformat{\part}[display]
  {\centering\sffamily}
  {\LARGE\bfseries\partname\ \thepart}
  {0mm}
  {\bfseries\fontsize{38}{40}\selectfont}

% Table of contents
\NewDocumentCommand{\maintoc}{}{{\let\onecolumn\relax \tableofcontents}}

% Default style for chapters
\newcommand{\uchapterlabel}{Chapter}
\def\@@chapterlable{\uchapterlabel}
\let\@@chapterclear\clearpage
\let\oldchapter\chapter
\RenewDocumentCommand{\chapter}{s m}{
  \@@chapterclear
  \thispagestyle{fancy-pagenum}
  \begingroup
    \IfBooleanTF{#1}
      {
        \addcontentsline{toc}{chapter}{#2}
        \phantom{{\sffamily\large\bfseries\@@chapterlable~\thechapter.}}
      }
      {
        \stepcounter{chapter}
        \addcontentsline{toc}{chapter}{\thechapter.~#2}
        {\sffamily\large\bfseries\@@chapterlable~\thechapter.}
      }
    \par\vspace*{1.5em}
    {\sffamily\Huge\bfseries #2}
    \par\vspace*{7.5em}
  \markboth{\thechapter\ #2}{}
  \endgroup
}

\titleformat*{\section}{\sffamily\bfseries\Large}
\titleformat*{\subsection}{\sffamily\bfseries\large}

%------------------------------------------------------------
% LOCAL TABLE OF CONTENTS
%------------------------------------------------------------
\RequirePackage{etoc}
\newcommand{\localtoc}{
  \begingroup
    \etocsettocstyle{}{} % clear default headings
    \etocsetnexttocdepth{section} % show entries down to section level
    \etocsetstyle{section}
      {\parindent -7mm}
      {\leftskip 7mm}
      {
        \bfseries\small\etocnumber\hspace*{2mm}\etocname\nobreak
        \hskip5pt\dotfill\hskip5pt\nobreak
        \etocpage\par\vspace*{1mm}
      }
      {}
    \localtableofcontents
  \endgroup
}

%------------------------------------------------------------
% CAPTIONS
%------------------------------------------------------------
\RequirePackage[font=small,labelfont=bf,labelsep=endash]{caption}
\DeclareCaptionStyle{widefigure}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{widetable}{font=small,labelfont=bf,labelsep=endash}

%------------------------------------------------------------
% VARIOUS RULERS, SEPARATORS & DIVIDERS
%------------------------------------------------------------
\newcommand{\rulethick}[1][darkgray]{\par\textcolor{#1}{\rule{\linewidth}{4pt}}\par}
\newcommand{\rulethin}[1][black]{\par\textcolor{#1}{\rule{\linewidth}{1pt}}\par}


%------------------------------------------------------------
% THE BOX
%------------------------------------------------------------
% For highly customisable boxes
\RequirePackage{mdframed}
\newmdenv[hidealllines=true, backgroundcolor=lightgray, skipabove=10pt, skipbelow=10pt, innerleftmargin=8pt, innerrightmargin=8pt, innertopmargin=10pt, innerbottommargin=10pt]{colbox}

%------------------------------------------------------------
% ENV,CMD: GENERAL PURPOSE; ASIDE, TEXTBOX, SUMMARY, EXERCISES
%------------------------------------------------------------

% usage: \being{aside}[heading]...\end{aside}
\newenvironment{aside}[1][Aside:]
  {\par\sffamily\textbf{#1\ }}{\normalfont\par}

% usage: \begin{textbox}[colour]...\end{textbox}
\newenvironment{textbox}[1][lightgray]
  {\begin{colbox}[backgroundcolor=#1]}{\end{colbox}}

% usage: \begin{summary}...\end{summary}
\newenvironment{summary}
  {\begin{colbox}\setlist[itemize]{leftmargin=*}}{\end{colbox}}

% usage: \begin{problems}[heading]\item...\item...\end{problems}
\newenvironment{problems}[1][Exercises:]{
  \rulethick\vspace*{-3mm}
  \setlist[enumerate,1]{label=(\thechapter.\arabic*)}
  \setlist[enumerate,2]{label=(\alph*)}
  \section*{#1}
  \begin{enumerate}
}{
  \end{enumerate}
}

%------------------------------------------------------------
% PAGES: OPTIONAL HALF-TITLE PAGE, BLANK & ART PAGES
%------------------------------------------------------------
% usage: \halftitlepage[custom-title]
\NewDocumentCommand{\halftitlepage}{o}{%
  \IfValueTF{#1}{\def\@halftitletext{#1}}{\def\@halftitletext{\utitle}}%
  \newpage\thispagestyle{empty}\null\vspace{0.3\textheight}
  {\centering\huge\sffamily\@halftitletext\par}
  \newpage
}

% usage: \blankpage[custom-text]
\NewDocumentCommand{\blankpage}{O{This page left blank intentionally}}{
  \newpage\thispagestyle{empty}\null\vspace{0.3\textheight}
  {\centering\textit{#1}\par}
  \newpage
}

% usage: \artpage[width]{image-file}[caption]
\NewDocumentCommand{\artpage}{O{\linewidth}mo}{%
  \IfValueTF{#3}{\def\@artpagetext{\par#3}}{\let\@artpagetext\relax}%
  \newpage\thispagestyle{empty}\null\vfill{\centering\includegraphics[width=#1]{#2}\@artpagetext\par}\vfill\null\newpage
}

%------------------------------------------------------------
% LISTS
%------------------------------------------------------------
\RequirePackage{enumitem}
\setlist[itemize,3]{label={$\circ$}}
\setlist[itemize,4]{label={\textasteriskcentered}}

%------------------------------------------------------------
% TABLES
%------------------------------------------------------------
\usepackage{booktabs,tabularx}
\newcolumntype{C}{>{\centering\arraybackslash}X}
\newcolumntype{L}{>{\raggedright\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}

%------------------------------------------------------------
% BIBLIOGRAPHY
%------------------------------------------------------------
\bibliographystyle{naturemag}

\DeclareDocumentCommand{\printbibliography}{m}{
  \clearpage
  \begingroup
  \small\twocolumn
  \bibliography{#1}
  \endgroup
}
