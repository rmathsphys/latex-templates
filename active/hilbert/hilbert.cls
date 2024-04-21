%-------------------------------------------------------------
% GENERAL HANDY PACKAGES (MUST BE LOADED AFTER THE BASE CLASS)
%-------------------------------------------------------------
\RequirePackage{etoolbox} % lots of powerful macros
\RequirePackage{xparse} % lots of powerful macros
\RequirePackage{calc} % for various calculations

%-------------------------------------------------------------
% INITIALIZING & HANDLING CLASS OPTIONS
%-------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hilbert}[2021/07/02 Inspired by the Two-Line style]

% Font options
\def\@@ptsize{11pt}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}} % this is the default option
\DeclareOption{12pt}{\def\@@ptsize{12pt}}

% Indentation options
\def\@@docindent{}
\DeclareOption{indent}{\def\@@docindent{indent}}
\DeclareOption{noindent}{\def\@@docindent{}} % this is the default option

% Ignore all other options
\DeclareOption*{\PackageWarning{hilbert}{Unknown '\CurrentOption'}}
\ProcessOptions\relax

\LoadClass[\@@ptsize]{book} % to be built on top of the book class

%-------------------------------------------------------------
% DOCUMENT INFORMATION COMMANDS
%-------------------------------------------------------------
\DeclareDocumentCommand{\date}{m}{\newcommand{\udate}{#1}\renewcommand{\@date}{#1}}
\DeclareDocumentCommand{\title}{m}{\newcommand{\utitle}{#1}\renewcommand{\@title}{#1}}
\DeclareDocumentCommand{\author}{m}{\newcommand{\uauthor}{#1}\renewcommand{\@author}{#1}}
\DeclareDocumentCommand{\affiliation}{m}{\newcommand{\uaffiliation}{#1}}
\DeclareDocumentCommand{\isbn}{m}{\newcommand{\uisbn}{#1}}
\DeclareDocumentCommand{\publisher}{m}{\newcommand{\upublisher}{#1}}
\DeclareDocumentCommand{\edition}{m}{\newcommand{\uedition}{#1}}
\DeclareDocumentCommand{\volume}{m}{\newcommand{\uvolume}{#1}}
\DeclareDocumentCommand{\revision}{m}{\newcommand{\urevision}{#1}}
\DeclareDocumentCommand{\website}{m}{\newcommand{\uwebsite}{#1}}

%--------------------------------------------------------------
% COLOURS
%--------------------------------------------------------------
\RequirePackage{graphicx}
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

%-------------------------------------------------------------
% GLOBAL TYPOGRAPHY
%-------------------------------------------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage{fontenc}

\RequirePackage{microtype}
\RequirePackage[\@@docindent]{parskip}

\usepackage[semibold,scale=.9]{sourcesanspro}
\usepackage[osf]{libertine}
\usepackage[libertine]{newtxmath}
\usepackage{inconsolata}
\renewcommand{\sfdefault}{SourceSansPro-LF}

%-------------------------------------------------------------
% STANDARD PAGE LAYOUT
%-------------------------------------------------------------
\RequirePackage{geometry}
  \geometry{papersize={129mm, 198mm}}
  \geometry{top=14mm, bottom=16mm, left=18mm, right=18mm}
  \geometry{includehead, includefoot, footskip=8mm}
  \geometry{nomarginpar}

% Those blank pages ... should be COMPLETELY blank
\renewcommand*{\cleardoublepage}{
  \clearpage
  \ifodd
    \c@page
  \else
    \null\thispagestyle{empty}\newpage
  \fi
}

%-------------------------------------------------------------
% HEADERS & FOOTERS
%-------------------------------------------------------------
\RequirePackage{fancyhdr}
  \pagestyle{fancy}
  \renewcommand{\chaptermark}[1]{\markboth{#1}{}}
  \renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
  
  \fancypagestyle{fancy-front}{
    \fancyhf{}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{0pt} 
  }
  \fancypagestyle{fancy-main}{
    \fancyhf{}
    \fancyhead[CO]{\small\scshape\leftmark}
    \fancyhead[CE]{\small\scshape\utitle}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{0pt}
  }
  \fancypagestyle{fancy-back}{
    \fancyhf{}
    \fancyhead[CO]{\small\scshape\leftmark}
    \fancyhead[CE]{\small\scshape\utitle}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{0pt} 
  }
  % Redefining the 'plain' header-footer style to be empty
  \fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt} 
  }

%-------------------------------------------------------------
% FRONT-, MAIN-, BACK- MATTERS BEHAVIOUR
%-------------------------------------------------------------
% Front matter
\let\oldfrontmatter\frontmatter % Store the old command
\renewcommand{\frontmatter}{
  \oldfrontmatter % First of all, call the old command
  \@openrightfalse
  \pagestyle{empty}
}

% Main matter
\let\oldmainmatter\mainmatter % Store the old command
\renewcommand{\mainmatter}{
  \oldmainmatter % Call the old command
  \@openrighttrue
  \pagestyle{fancy-main}
}

% Back matter
\let\oldbackmatter\backmatter % Store the old command
\renewcommand{\backmatter}{
  \oldbackmatter % Call the old command
  \@openrightfalse
  \pagestyle{fancy-back}
}

%-------------------------------------------------------------
% TABLE OF CONTENTS
%-------------------------------------------------------------
\RequirePackage{titletoc}

\titlecontents{chapter}
  [3mm]
  {\large\itshape\vspace{3mm}}
  {\thecontentslabel\quad}
  {}
  {\titlerule*[2mm]{.}\contentspage\hspace*{3mm}}

%-------------------------------------------------------------
% HEADINGS: CHAPTERS
%-------------------------------------------------------------
\RequirePackage{titlesec}

\titleformat{\chapter}[display]
  {\vspace*{-10mm}}
  {\centering\LARGE\thechapter}
  {3mm}
  {\centering\Huge\scshape}
  [\vspace*{-2mm}]

% TODO: Add other styles here and enable easy switching.

%-------------------------------------------------------------
% ENV: GENERAL PURPOSE; QUOTE
%-------------------------------------------------------------
\RequirePackage{changepage}
\renewenvironment{quote}
  {\begin{adjustwidth}{0.1\textwidth}{0.1\textwidth}}{\end{adjustwidth}}

%-------------------------------------------------------------
% PAGES: OPTIONAL HALF-TITLE PAGE, BLANK & ART PAGES
%-------------------------------------------------------------
% usage: \halftitlepage[custom-title]
\NewDocumentCommand{\halftitlepage}{o}{%
  \IfValueTF{#1}{\def\@halftitletext{#1}}{\def\@halftitletext{\utitle}}%
  \clearpage\thispagestyle{empty}\null\vspace{0.3\textheight}
  {\centering\scshape\Large\@halftitletext\par}
  \vfill\null\clearpage
}

% usage: \blankpage[custom-text]
\NewDocumentCommand{\blankpage}{o}{%
  \IfValueTF{#1}{\def\@blankpagetext{#1}}{\def\@blankpagetext{This page left blank intentionally}}%
  \clearpage\thispagestyle{empty}\null\vspace{0.3\textheight}
  {\centering\textit{\@blankpagetext}\par}
  \clearpage
}

% usage: \artpage[width]{image-file}[caption]
\NewDocumentCommand{\artpage}{O{\linewidth}mo}{%
  \IfValueTF{#3}{\def\@artpagetext{\par#3}}{\let\@artpagetext\relax}
  \clearpage\thispagestyle{empty}\null\vfill
  \begin{adjustwidth}{-10mm}{-10mm}\includegraphics[width=#1]{#2}\end{adjustwidth}
  \@artpagetext
  \vfill\null\clearpage
}

%-------------------------------------------------------------
% VARIOUS RULERS, SEPARATORS & DIVIDERS
%-------------------------------------------------------------
\newcommand{\rulethick}[1][darkgray]{\par\textcolor{#1}{\rule{\linewidth}{5pt}}\par}
\newcommand{\rulethin}[1][black]{\par\textcolor{#1}{\rule{\linewidth}{1pt}}\par}

%--------------------------------------------------------------
% EXTERNAL MODIFICATIONS
%--------------------------------------------------------------
% For highly customisable boxes
\RequirePackage{mdframed}
\newmdenv[hidealllines=true, backgroundcolor=lightgray, skipabove=10pt, skipbelow=10pt, innerleftmargin=8pt, innerrightmargin=8pt, innertopmargin=10pt, innerbottommargin=10pt]{colbox}

%--------------------------------------------------------------
% LISTS
%--------------------------------------------------------------
\RequirePackage{enumitem}
\setlist[itemize,3]{label={$\circ$}}
\setlist[itemize,4]{label={\textasteriskcentered}}

%--------------------------------------------------------------
% CAPTIONS
%--------------------------------------------------------------
\RequirePackage[font=small,labelfont=bf,labelsep=endash]{caption}
\DeclareCaptionStyle{marginfigure}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{sidecaption}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{widefigure}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{margintable}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{widetable}{font=small,labelfont=bf,labelsep=endash}

%--------------------------------------------------------------
% TABLES
%--------------------------------------------------------------
\usepackage{booktabs,tabularx}
\newcolumntype{C}{>{\centering\arraybackslash}X}
\newcolumntype{L}{>{\raggedright\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}
\newcolumntype{D}[1]{>{\centering\arraybackslash}p{#1}}
% \newcommand{\ra}[1]{\renewcommand{\arraystretch}{#1}}