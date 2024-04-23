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
\RequirePackage{microtype}
\RequirePackage{parskip}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

\RequirePackage{lmodern}

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
% AUXILIARY MACROS
%----------------------------------------------------------------------------------------
\def\@openingvspace{0.75em}
\def\@closingvspace{0.75em}

%----------------------------------------------------------------------------------------
% DOCUMENT-WIDE COMMANDS
%----------------------------------------------------------------------------------------
\providecommand\ufromaddress{}
\providecommand\utoaddress{}
\DeclareDocumentCommand{\fromaddress}{m}{ \renewcommand{\ufromaddress}{#1\par\vspace{\@closingvspace}} }
\DeclareDocumentCommand{\toaddress}{m}{ \renewcommand{\utoaddress}{#1\par\vspace{\@closingvspace}} }

\let\usubject\relax
\let\udate\relax
\let\usenderinfo\relax
\DeclareDocumentCommand{\subject}{m}{ \newcommand{\usubject}{\par\vspace{\@closingvspace} {\centering\bfseries#1\par}} }
\DeclareDocumentCommand{\date}{m}{ \newcommand{\udate}{#1} }
\DeclareDocumentCommand{\greeting}{m}{ \newcommand{\ugreeting}{#1} }

\newcommand\uclosingtag{Yours sincerely,}
\DeclareDocumentCommand{\closingtag}{m}{ \renewcommand{\uclosingtag}{#1} }
\DeclareDocumentCommand{\sender}{m}{ \newcommand{\usender}{\textbf{#1}} }
\DeclareDocumentCommand{\senderinfo}{m}{ \newcommand{\usenderinfo}{\newline#1} }


\providecommand\usignatureblock{}
\DeclareDocumentCommand{\signatureblock}{m}{ \ifblank{#1}{}{\renewcommand{\usignatureblock}{#1\par\vspace{\@closingvspace}}} }

%----------------------------------------------------------------------------------------
% OPENING SECTOR
%----------------------------------------------------------------------------------------
\newcommand{\@osleftright}{
  \begin{flushright}\ufromaddress\end{flushright}
  \utoaddress
  \udate
  \usubject
  \par\vspace{\@closingvspace}
  \ugreeting
  \par\vspace{\@closingvspace}
}

\newcommand{\@osleft}{
  \ufromaddress
  \utoaddress
  \udate
  \usubject
  \par\vspace{\@closingvspace}
  \ugreeting
  \par\vspace{\@closingvspace}
}

\newcommand{\@osmin}{
  \udate
  \par\vspace*{2mm}
  \par\ugreeting
  \par\vspace*{2mm}
}

\let\@osdefault\@osleft

%----------------------------------------------------------------------------------------
% CLOSING SECTOR
%----------------------------------------------------------------------------------------

\newcommand{\@closingsector}{
  \par\vspace{\@closingvspace}
  \uclosingtag
  \par\vspace{\@closingvspace}
  \usignatureblock
  \usender
  \usenderinfo
}

%----------------------------------------------------------------------------------------
% SOME FINAL TOUCHES
%----------------------------------------------------------------------------------------
\setlength{\parskip}{0.5em}
\pagestyle{empty}

\DeclareDocumentCommand{\printopening}{O{default}}{
  \expandafter\ifstrequal\expandafter{#1}{default}{\@osdefault}{}
  \expandafter\ifstrequal\expandafter{#1}{leftright}{\@osleftright}{}
  \expandafter\ifstrequal\expandafter{#1}{left}{\@osleft}{}
  \expandafter\ifstrequal\expandafter{#1}{min}{\@osmin}{}
}
\newcommand{\printclosing}{\@closingsector}