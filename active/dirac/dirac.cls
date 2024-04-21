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
\ProvidesClass{dirac}[2021/06/03]

\def\@@ptsize{11pt}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}} % this is the default option
\DeclareOption{12pt}{\def\@@ptsize{12pt}} 

\def\@@draftfinal{final}
\DeclareOption{draft}{\def\@@draftfinal{draft}}
\DeclareOption{final}{\def\@@draftfinal{final}} % this is the default option

\DeclareOption*{\PackageWarning{dirac}{Unknown '\CurrentOption'}}

\ProcessOptions\relax
\LoadClass[\@@ptsize,\@@draftfinal]{book} % to be built on top of the book class

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
\RequirePackage[a4paper]{geometry}

% The default page layout:
\geometry{includeall, top=14mm, bottom=14mm, left=13mm, right=13mm, headheight=16pt, marginparwidth=56mm, marginparsep=8mm}

% Additional page layout options: extrawide, extranarrow, margin (==default)
\newcommand{\setlayout}[1]{
  \ifstrequal{#1}{extrawide}
    {\newgeometry{includeall,nomarginpar,top=14mm,bottom=14mm,left=15mm,right=15mm,headheight=16pt}}{
  \ifstrequal{#1}{extranarrow}
    {\newgeometry{includeall,nomarginpar,top=14mm,bottom=14mm,left=35mm,right=35mm,headheight=16pt}}{
  \ifstrequal{#1}{margin}
    {\restoregeometry}{
  \ifstrequal{#1}{default}
    {\restoregeometry}{
  \PackageError{setlayout}{Undefined option to the setlayout command}{
  }}}}}
}

% Those automatic blank pages ... should be COMPLETELY blank
\renewcommand*{\cleardoublepage}{
  \clearpage
  \ifodd
    \c@page
  \else
    \null\thispagestyle{empty}\clearpage
  \fi
}

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
    \fancyheadoffset[LE,RO]{\marginparsep+\marginparwidth}
    \fancyhead[LE,RO]{\thepage}
    \fancyhead[RE]{\textsl{\leftmark}}
    \fancyhead[LO]{\textsl{\rightmark}}
    \renewcommand{\headrulewidth}{0pt}
  }

  % Header-Footer style showing only page numbers
  \fancypagestyle{fancy-pagenum}{
    \fancyhf{}
      \fancyheadoffset[LE,RO]{\marginparsep+\marginparwidth}
    \fancyhead[RO,LE]{\thepage}
    \renewcommand{\headrulewidth}{0pt}
  }

  % Redefining the 'plain' header-footer style to be empty
  \fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt} 
  }

% Activating the default header-footer style
\pagestyle{fancy-chapter}

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
  \@openrightfalse
  \setlayout{extranarrow}
}

% Main matter
\let\oldmainmatter\mainmatter % Store the old command
\renewcommand{\mainmatter}{
  \oldmainmatter % Call the old command
  \@openrighttrue
  \setlayout{default} % Use the default 1.5 column layout
  \pagestyle{fancy-chapter}
}

% Appendix
\let\oldappendix\appendix % Store the old command
\renewcommand{\appendix}{
  \oldappendix % Call the old command
  \renewcommand\chaptername{Appendix}
  \@openrightfalse
}

% Back matter
\let\oldbackmatter\backmatter % Store the old command
\renewcommand{\backmatter}{
  \oldbackmatter % Call the old command
  \@openrightfalse
  \bookmarksetup{startatroot} % Reset the bookmark depth
  \setlayout{extrawide} % Use the narrow text layout
  \pagestyle{fancy-pagenum}
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

\let\oldpart\part
\DeclareDocumentCommand{\part}{s O{#3} m}
  {\IfBooleanTF {#1}
    { \oldpart[#2]{#3} }
    { \setlayout{extranarrow}\oldpart[#2]{#3}\setlayout{default} }
  }

\DeclareDocumentEnvironment{partback}{O{#2} m}
  {\setlayout{extranarrow}\@openrightfalse\part*[#1]{#2}\thispagestyle{empty}}{\@openrighttrue\setlayout{default}}


% Default style for chapters
\titleformat{\chapter}[display]
  {\vspace*{-5mm}\sffamily}
  {\large\bfseries\chaptername\ \thechapter}
  {0mm}
  {\bfseries\Huge}
  [\vspace*{-5mm}]

\titleformat*{\section}{\sffamily\bfseries\Large}
\titleformat*{\subsection}{\sffamily\bfseries\large}

%------------------------------------------------------------
% MARGIN & SIDE NOTES GENERAL
%------------------------------------------------------------
\RequirePackage{sidenotes}
% Convert footnotes to sidenotes
\let\oldfootnote\footnote
\let\footnote\sidenote

\RequirePackage{marginnote}
% Force marginnotes to follow default text alignment
\renewcommand*{\raggedleftmarginnote}{}
\renewcommand*{\raggedrightmarginnote}{}

%------------------------------------------------------------
% CAPTIONS
%------------------------------------------------------------
\RequirePackage[font=small,labelfont=bf,labelsep=endash]{caption}
\DeclareCaptionStyle{marginfigure}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{sidecaption}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{widefigure}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{margintable}{font=small,labelfont=bf,labelsep=endash}
\DeclareCaptionStyle{widetable}{font=small,labelfont=bf,labelsep=endash}

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
      {\parindent -7mm}
      {\leftskip 7mm}
      {\bfseries\small\etocnumber\hspace*{2mm}\etocname\nobreak\hfill\nobreak\etocpage\par\vspace*{1mm}}
      {}
    \marginnote{\localtableofcontents}[#1] % print this toc in the margin
  \endgroup
}

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
% ENV,CMD: GENERAL PURPOSE; QUOTE, ASIDE, MARGINBOX, TEXTBOX, WIDE TEXT, SUMMARY
%------------------------------------------------------------
% usage: \being{quote}...\end{quote}
\RequirePackage{changepage}

\renewenvironment{quote}
  {\begin{adjustwidth}{0.1\textwidth}{0.1\textwidth}}{\end{adjustwidth}}

% usage: \being{aside}[heading]...\end{aside}
\newenvironment{aside}[1][Aside:]
  {\par\sffamily\textbf{#1\ }}{\normalfont\par}


\let\oldmarginnote\marginnote
% \renewcommand{\marginnote}[1]{\oldmarginnote{\footnotesize#1}}

% usage: \marginbox{...}
\newcommand{\marginbox}[1]
  {\oldmarginnote{\begin{colbox}\footnotesize#1\end{colbox}}}

% usage: \begin{textbox}[colour]...\end{textbox}
\newenvironment{textbox}[1][lightgray]
  {\begin{colbox}[backgroundcolor=#1]}{\end{colbox}}

% usage: \begin{widetext}[colour]...\end{widetext}
\newenvironment{widetext}
  {\begin{adjustwidth}{0mm}{-\marginparsep-\marginparwidth}}{\end{adjustwidth}}

% usage: \begin{summary}...\end{summary}
\newenvironment{summary}
  {\begin{colbox}\setlist[itemize]{leftmargin=*}}{\end{colbox}}

%------------------------------------------------------------
% ENV: FULL WIDTH, TWO COLUMN EXERCISES
%------------------------------------------------------------
\RequirePackage{multicol}
\RequirePackage[twosidemode, needspace=3mm, outermargin=-\marginparsep-\marginparwidth]{fullwidth}

% usage: \begin{problems}[heading]\item...\item...\end{problems}
\newenvironment{problems}[1][Exercises:]{
    \begin{fullwidth}[width=\linewidth+\marginparsep+\marginparwidth]
    \rulethick\vspace*{-3mm}
    \setlist[enumerate,1]{label=(\thechapter.\arabic*)}
    \setlist[enumerate,2]{label=(\alph*)}
    \section*{#1}
    \begin{multicols}{2}\begin{enumerate}
  }{
    \end{enumerate}\end{multicols}\end{fullwidth}
  }

%------------------------------------------------------------
% PAGES: OPTIONAL HALF-TITLE PAGE, BLANK & ART PAGES
%------------------------------------------------------------
% usage: \halftitlepage[custom-title]
\NewDocumentCommand{\halftitlepage}{o}{%
  \IfValueTF{#1}{\def\@halftitletext{#1}}{\def\@halftitletext{\utitle}}%
  \clearpage\thispagestyle{empty}\null\vspace{0.3\textheight}
  {\centering\huge\sffamily\@halftitletext\par}
  \clearpage
}

% usage: \blankpage[custom-text]
\NewDocumentCommand{\blankpage}{O{This page left blank intentionally}}{
  \clearpage\thispagestyle{empty}\null\vspace{0.3\textheight}
  {\centering\textit{#1}\par}
  \clearpage
}

% usage: \artpage[width]{image-file}[caption]
\NewDocumentCommand{\artpage}{O{\linewidth}mo}{%
  \IfValueTF{#3}{\def\@artpagetext{\par#3}}{\let\@artpagetext\relax}%
  \clearpage\thispagestyle{empty}\null\vfill\includegraphics[width=#1]{#2}\@artpagetext\vfill\null\clearpage
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
