%----------------------------------------------------------------------------------------
% GENERAL HANDY PACKAGES (MUST BE LOADED AFTER THE BASE CLASS)
%----------------------------------------------------------------------------------------
\RequirePackage{etoolbox} % lots of powerful macros
\RequirePackage{xparse} % lots of powerful macros
\RequirePackage{calc} % for various calculations

%----------------------------------------------------------------------------------------
% INITIALIZING & HANDLING CLASS OPTIONS
%----------------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hilbert}[2019/11/16 Inspired by the Two-Line style]

% Font options
\def\@@ptsize{11pt}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}} % this is the default option
\DeclareOption{12pt}{\def\@@ptsize{12pt}}

% Ignore all other options
\DeclareOption*{\PackageWarning{hilbert}{Unknown '\CurrentOption'}}
\ProcessOptions\relax

\LoadClass[\@@ptsize]{book} % to be built on top of the book class

%----------------------------------------------------------------------------------------
% DOCUMENT INFORMATION COMMANDS
%----------------------------------------------------------------------------------------
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

%----------------------------------------------------------------------------------------
% GLOBAL TYPOGRAPHY
%----------------------------------------------------------------------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[osf]{libertine}
\RequirePackage[libertine]{newtxmath}
\RequirePackage{inconsolata}
\RequirePackage{microtype}
\RequirePackage{parskip}

%----------------------------------------------------------------------------------------
% COLOURS. A TRADITION
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
% STANDARD PAGE LAYOUT
%----------------------------------------------------------------------------------------
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

%----------------------------------------------------------------------------------------
% HEADERS & FOOTERS
%----------------------------------------------------------------------------------------
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

%----------------------------------------------------------------------------------------
% FRONT-, MAIN-, BACK- MATTERS BEHAVIOUR
%----------------------------------------------------------------------------------------
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

%----------------------------------------------------------------------------------------
% TABLE OF CONTENTS
%----------------------------------------------------------------------------------------
\RequirePackage{titletoc}

\titlecontents{chapter}
  [3mm]
  {\large\itshape\vspace{3mm}}
  {\thecontentslabel\quad}
  {}
  {\titlerule*[2mm]{.}\contentspage\hspace*{3mm}}

%----------------------------------------------------------------------------------------
% HEADINGS: CHAPTERS
%----------------------------------------------------------------------------------------
\RequirePackage{titlesec}

\titleformat{\chapter}[display]
  {\vspace*{-10mm}}
  {\centering\LARGE\thechapter}
  {3mm}
  {\centering\Huge\scshape}
  [\vspace*{-2mm}]

% TODO: Add other styles here and enable easy switching.

%----------------------------------------------------------------------------------------
% PAGE: OPTIONAL HALF-TITLE PAGE
%----------------------------------------------------------------------------------------
\NewDocumentCommand{\halftitlepage}{o}{%
  \IfValueTF{#1}{\def\@halftitletext{#1}}{\def\@halftitletext{\utitle}}%
  \clearpage\null\vspace*{0.3\textheight}
  {\centering\scshape\Large\@halftitletext\par}
  \vfill\null\clearpage
}

%----------------------------------------------------------------------------------------
% ENV: GENERAL PURPOSE; QUOTE
%----------------------------------------------------------------------------------------
\RequirePackage{changepage}
\renewenvironment{quote}
  {\begin{adjustwidth}{14mm}{14mm}\raggedright}{\end{adjustwidth}}

%----------------------------------------------------------------------------------------
% PAGE: BLANK & ART PAGES
%----------------------------------------------------------------------------------------
\NewDocumentCommand{\blankpage}{o}{%
  \IfValueTF{#1}{\def\@blankpagetext{#1}}{\def\@blankpagetext{This page left blank intentionally}}%
  \clearpage\thispagestyle{empty}\null\vspace{0.3\textheight}
  {\centering\textit{\@blankpagetext}\par}
  \clearpage
}

\NewDocumentCommand{\artpage}{O{\linewidth}mo}{%
  \IfValueTF{#3}{\def\@artpagetext{\par#3}}{\let\@artpagetext\relax}
  \clearpage\thispagestyle{empty}\null\vfill
  \begin{adjustwidth}{-10mm}{-10mm}\includegraphics[width=#1]{#2}\end{adjustwidth}
  \@artpagetext
  \vfill\null\clearpage
}

%----------------------------------------------------------------------------------------
% VARIOUS RULERS, SEPARATORS & DIVIDERS
%----------------------------------------------------------------------------------------
\newcommand{\rulethick}[1][darkgray]{\par\textcolor{#1}{\rule{\linewidth}{5pt}}\par}
\newcommand{\rulethin}[1][black]{\par\textcolor{#1}{\rule{\linewidth}{1pt}}\par}