%----------------------------------------------------------------------------------------
% GENERAL HANDY PACKAGES
%----------------------------------------------------------------------------------------
\RequirePackage{xparse} % lots of powerful macros
\RequirePackage{graphicx} % for graphics; mainly the signature

%----------------------------------------------------------------------------------------
% INITIALIZING & HANDLING CLASS OPTIONS
%----------------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wade}[2019/11/15 A simple, personalised letter class]

% Font options
\def\@@ptsize{12pt}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}} % this is the default option

% Ignore all other options
\DeclareOption*{\PackageWarning{wade}{Unknown '\CurrentOption'}}
\ProcessOptions\relax

\LoadClass[\@@ptsize]{article} % to be built on top of the article class

%----------------------------------------------------------------------------------------
% GLOBAL TYPOGRAPHY
%----------------------------------------------------------------------------------------
% \RequirePackage{lmodern}
\RequirePackage{microtype}
\RequirePackage{parskip}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

\usepackage[semibold,scale=.9]{sourcesanspro}
\usepackage{libertine}
\usepackage[libertine]{newtxmath}
\usepackage{inconsolata}
\renewcommand{\sfdefault}{SourceSansPro-LF}

%----------------------------------------------------------------------------------------
% STANDARD PAGE LAYOUTS
%----------------------------------------------------------------------------------------
\RequirePackage[a4paper]{geometry}
\geometry{margin={28mm, 25mm}, nomarginpar}

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
% HYPERLINKS (WHY WOULD YOU ADD HYPERLINKS IN YOUR LETTER???)
%----------------------------------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  citecolor=crimson,
  linkcolor=crimson,
  filecolor=teal,
  urlcolor=teal
}

%----------------------------------------------------------------------------------------
% ADDRESS SECTOR
%----------------------------------------------------------------------------------------
\let\ufromaddress\relax
\let\utoaddress\relax
\DeclareDocumentCommand{\fromaddress}{m}{\newcommand{\ufromaddress}{\begin{flushright}#1\end{flushright}}}
\DeclareDocumentCommand{\toaddress}{m}{\newcommand{\utoaddress}{#1}}

\newcommand{\@addressector}{
  \ufromaddress\utoaddress\par\vspace*{6mm}
}

%----------------------------------------------------------------------------------------
% GREETINGS & SUBJECT SECTOR
%----------------------------------------------------------------------------------------
\let\usubject\relax
\def\udate{\today}
\DeclareDocumentCommand{\subject}{m}{\newcommand{\usubject}{\par{\centering\bfseries#1\par}\vspace*{5mm}}}
\DeclareDocumentCommand{\date}{m}{\renewcommand{\udate}{\par\hfill#1}}
\DeclareDocumentCommand{\greeting}{m}{\newcommand{\ugreeting}{\par#1}}

\newcommand{\@greetingsector}{
  \usubject\udate\ugreeting\par\vspace*{2mm}
}

%----------------------------------------------------------------------------------------
% CLOSING SECTOR
%----------------------------------------------------------------------------------------
\def\uclosingtag{Yours sincerely,}
\let\usignaturefile\relax
\let\usenderinfo\relax
\DeclareDocumentCommand{\closingtag}{m}{\renewcommand{\uclosingtag}{\par\vspace*{2mm}\par#1\par\vspace*{4mm}}}
\DeclareDocumentCommand{\signaturefile}{m}{\newcommand{\usignaturefile}{\par\includegraphics[height=10mm]{#1}\par\vspace*{2mm}}}
\DeclareDocumentCommand{\sender}{m}{\newcommand{\usender}{\par\textbf{#1}}}
\DeclareDocumentCommand{\senderinfo}{m}{\newcommand{\usenderinfo}{\newline#1}}

\newcommand{\@closingsector}{
  \uclosingtag
  \usignaturefile
  \usender
  \usenderinfo
  \par\vspace*{6mm}
}

%----------------------------------------------------------------------------------------
% SOME FINAL TOUCHES
%----------------------------------------------------------------------------------------
\setlength{\parskip}{0.5em}
\pagestyle{empty}

\newcommand{\printopening}{\@addressector\@greetingsector}
\newcommand{\printclosing}{\@closingsector}