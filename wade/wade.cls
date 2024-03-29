%----------------------------------------------------------------------------------------
% GENERAL HANDY PACKAGES
%----------------------------------------------------------------------------------------
\RequirePackage{xparse} % lots of powerful macros
\RequirePackage{etoolbox} % lots of powerful macros
\RequirePackage{graphicx} % for graphics; mainly the signature

%----------------------------------------------------------------------------------------
% INITIALIZING & HANDLING CLASS OPTIONS
%----------------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wade}[2024/03/29 A simple, personalised letter class]

% Font options
\def\@@ptsize{11pt}
\newtoggle{@@uselibertine}

\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}} % this is the default option
\DeclareOption{uselibertine}{\toggletrue{@@uselibertine}}

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

\RequirePackage{lmodern}
\iftoggle{@@uselibertine}{\RequirePackage{libertine}\RequirePackage{inconsolata}}{}

% \renewcommand{\sfdefault}{SourceSansPro-LF}

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
% DOCUMENT-WIDE COMMANDS
%----------------------------------------------------------------------------------------
% Optional entries
\let\ufromaddress\relax
\let\utoaddress\relax
\let\usubject\relax
\let\udate\relax
\let\usignaturefile\relax
\let\usenderinfo\relax

% Entries with a default value
\def\uclosingtag{Yours sincerely,}

\DeclareDocumentCommand{\fromaddress}{m}{\newcommand{\ufromaddress}{#1}}
\DeclareDocumentCommand{\toaddress}{m}{\newcommand{\utoaddress}{#1}}
\DeclareDocumentCommand{\subject}{m}{\newcommand{\usubject}{#1}}
\DeclareDocumentCommand{\date}{m}{\newcommand{\udate}{#1}}
\DeclareDocumentCommand{\greeting}{m}{\newcommand{\ugreeting}{#1}}
\DeclareDocumentCommand{\closingtag}{m}{\renewcommand{\uclosingtag}{\par\vspace*{2mm}\par#1\par\vspace*{4mm}}}
\DeclareDocumentCommand{\signaturefile}{m}{\newcommand{\usignaturefile}{\par\includegraphics[height=10mm]{#1}\par\vspace*{2mm}}}
\DeclareDocumentCommand{\sender}{m}{\newcommand{\usender}{\par\textbf{#1}}}
\DeclareDocumentCommand{\senderinfo}{m}{\newcommand{\usenderinfo}{\newline#1}}

%----------------------------------------------------------------------------------------
% OPENING SECTOR
%----------------------------------------------------------------------------------------

\newcommand{\@osdefault}{
  \begin{flushright}\ufromaddress\\\udate\end{flushright}
  \utoaddress
  \par\vspace*{6mm}
  \par{\centering\bfseries\usubject\par}\vspace*{5mm}
  \par\ugreeting
  \par\vspace*{2mm}
}

\newcommand{\@osleft}{
  \ufromaddress
  \par\udate\par\vspace*{6mm}
  \par\utoaddress\par\vspace*{4mm}
  \par{\centering\bfseries\usubject\par}\vspace*{4mm}
  \par\ugreeting
  \par\vspace*{2mm}
}

\newcommand{\@osmin}{
  \ufromaddress
  \par\udate
  \par\vspace*{2mm}
  \par\ugreeting
  \par\vspace*{2mm}
}

%----------------------------------------------------------------------------------------
% CLOSING SECTOR
%----------------------------------------------------------------------------------------

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

% \newcommand{\printopening}{\@openingsectora}
\DeclareDocumentCommand{\printopening}{m}{
  \expandafter\ifstrequal\expandafter{#1}{left}{\let\@osdefault\relax\@osleft}{}
  \expandafter\ifstrequal\expandafter{#1}{min}{\let\@osdefault\relax\@osmin}{}
  \@osdefault
}
\newcommand{\printclosing}{\@closingsector}