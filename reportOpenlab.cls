%--------------------- Definition ------------------------
\ProvidesClass{reportOpenlab}[2022/07/27 LaTeX version of CERN openlab report]
% description: minimal customisation of LaTeX article class to match openlab template

\LoadClassWithOptions{article}


%--------------------- packages ------------------------

\RequirePackage[utf8]{inputenc} % special characters
\RequirePackage[T1]{fontenc}
\usepackage{helvet}             % use this sf font

\RequirePackage{float}          % placement of images
\RequirePackage{fancyhdr}       % custom headers and footers
\RequirePackage{biblatex}       % bibliography
\RequirePackage{url}            % Links
\RequirePackage{biblatex}       % bibliography

\RequirePackage{hyperref}
\hypersetup{
    colorlinks,
    linkcolor={openlabbluedark},
    citecolor={openlabviolet},
    urlcolor={openlabbluedark},
    linktoc=all
}
\RequirePackage[left=2cm,right=2cm, top=2.5cm,bottom=3.0cm]{geometry} % set margins
%%  NOTE (TODO) 
%    As of the current version, changing the top/bottom geometry does not 
%    correct the position of header and footer geometrical elements, which 
%    are instead anchored to the bottom and top of paper.
%    This is a possible improvement for next year summer students!


%%  define custom color palette
\RequirePackage{xcolor}
\definecolor{openlabbluelight}{RGB}{42,125,191}
\definecolor{openlabbluedark}{RGB}{64,70,147}
\definecolor{openlabblueverydark}{RGB}{47,50,85}
\definecolor{openlabviolet}{RGB}{64,70,147}
\definecolor{openlabgreen}{RGB}{45,178,159}
\definecolor{openlaborange}{RGB}{255,168,76}
\definecolor{openlabred}{RGB}{255,59,87}

%% graphics
\RequirePackage{graphicx}
\RequirePackage{tikz} % tikz graphics
\usetikzlibrary{calc,positioning}

%% caption
\RequirePackage{caption}
\captionsetup{justification=centering,labelfont={bf,sf},font=small,labelformat={default}}


%--------------------- code snippets ------------------------
\newboolean{printCode}
\RequirePackage{ifthen}
\AtBeginDocument{%
  \IfFileExists{minted.sty}{%
    \RequirePackage{minted}%

    \newenvironment{longlisting}{\captionsetup{type=listing}}{} % custom environment that allows to break pages for long code snippets
    \setboolean{printCode}{true}%
  }{%
    \setboolean{printCode}{false}
    \PackageWarning{reportOpenlab}{%
      Package minted not available.
    }%
  }%
}

%---------------------- Layout -------------------------

% sets layout of sections, subsections, ...
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\Large\bfseries\sffamily\color{openlabgreen}\MakeUppercase}}
\renewcommand\subsection{\@startsection {subsection}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\large\bfseries\sffamily\color{openlaborange}\MakeUppercase}}
\renewcommand{\thesubsection}{\alph{subsection}.}
\renewcommand\subsubsection{\@startsection {subsubsection}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\bfseries\sffamily\color{openlabred}}}
\renewcommand{\thesubsubsection}{\hspace{1em}\roman{subsubsection}.}


%--------------------- Titlepage ------------------------

\DeclareRobustCommand*{\institute}[1]{\gdef\@institute{#1}}
\DeclareRobustCommand*{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\maketitlepage}{
\begin{titlepage}
        \begin{tikzpicture}[overlay,remember picture]
            \node at ($(current page.north west)+(2.5cm,-3cm)$) {\includegraphics[width=1.5\textwidth]{assets/front.png}};
        \end{tikzpicture}
        \vskip8cm
        \begin{center}
                {\textbf{\color{openlabbluelight}{\MakeUppercase{\sffamily\Huge {\@title}}}}}\\
        \end{center}
        \vskip0.5cm
        \hspace{0.05\textwidth} { \sffamily\LARGE\textbf{\color{openlabbluedark}{{\@date}}}}\\
        \vskip2cm
        \hspace{0.5\textwidth}
        \begin{minipage}{0.7\textwidth}
            %\large
            \sffamily
            {\color{openlabblueverydark}{
                \textbf{AUTHOR(S):}\\\@author\vskip0.5cm\@institute
                \vskip0.5cm
                \textbf{SUPERVISOR(S):}\\\@supervisor
            }}
        \end{minipage}
        \vfill
        \begin{center}\includegraphics[width=0.4\textwidth]{assets/cern_openlab_logo.png}\end{center}
\end{titlepage}
\clearpage
}

%--------------------- Specifications ------------------------

\newcommand{\specification}[1]{
{\color{openlabviolet}{
    \noindent\textbf{\sffamily\large PROJECT SPECIFICATION}\\
    \includegraphics[width=0.7\textwidth]{assets/hline1.png}\\
}}\\
#1
\clearpage
}

%--------------------- Abstract ------------------------

\renewcommand{\abstract}[1]{
{\color{openlabviolet}{
    \noindent\textbf{\sffamily\large ABSTRACT}\\
    \includegraphics[width=0.7\textwidth]{assets/hline1.png}\\
}}
\\
#1
\clearpage
}

%--------------------- Table of contents ------------------------

\RequirePackage{tocloft}

% use sf in ToC + bold font
\renewcommand{\cftsecfont}{\bfseries\sffamily}
\renewcommand{\cftsubsecfont}{\bfseries\sffamily}
\renewcommand{\cftsubsubsecfont}{\sffamily}

% adjust spacing in ToC
\renewcommand\cftsecafterpnum{\vskip10pt}

% fix page header and footer
\tocloftpagestyle{fancy}
\renewcommand{\contentsname}{{\color{openlabviolet}{\noindent\textbf{\sffamily\large TABLE OF CONTENTS\\\includegraphics[width=0.7\textwidth]{assets/hline1.png}}}}\vspace{1em}}
\let\originaltableofcontents\tableofcontents
\renewcommand\tableofcontents{%
%  \cleardoublepage
%  \pagestyle{empty}%
  \originaltableofcontents
  \thispagesytle{fancy}
}


%--------------------- Headers and footers ------------------------
% clear default layout
\fancyhf{}
\renewcommand{\headrulewidth}{0pt} % remove header rule
\setlength{\headheight}{15pt} % it removes compilation warning
\renewcommand{\footrulewidth}{0pt} % remove footer rule
% define header
\DeclareRobustCommand*{\reportnumber}[1]{\gdef\@reportnumber{#1}}
\fancyhead[L]{\textbf{\textit{\sffamily\scriptsize\color{openlabviolet}{CERN openlab Report  \@reportnumber \begin{tikzpicture}[overlay,remember picture] \node[anchor=north east, xshift=-1.3cm,yshift=-4mm] at (current page.north east) {\includegraphics[width=1.5cm]{assets/cern_openlab_logo_small.png}};\end{tikzpicture}}}}}
% define footer
\fancyfoot[R]{{\sffamily\scriptsize\color{openlabbluelight}{\thepage}}}
\fancyfoot[L]{{\sffamily\scriptsize\color{openlabviolet}\textit{\MakeUppercase\@title}}%
    \begin{tikzpicture}[overlay,remember picture,node distance=-0.2cm] 
    \node[yshift=1.55cm] at (current page.south) (centre){\includegraphics[width=0.33\textwidth]{assets/hline2.png}};%
    \node[left=of centre, anchor=east] {\includegraphics[width=0.33\textwidth]{assets/hline2.png}};%
    \node[right=of centre, anchor=west] {\includegraphics[width=0.33\textwidth]{assets/hline2.png}};\end{tikzpicture}}
\pagestyle{fancy}
