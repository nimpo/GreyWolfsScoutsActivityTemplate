%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Copyright 2022 Mike Jones, <dr.mike.jones@gmail.com>
%% AKA Grey Wolf <mike.jones@mansouthscouts.org>
%% AKA Akela <mike.jones@mansouthscouts.org>
%% [23rd Manchester (Birch with Fallowfield)]
%% Scout Membership number: 12114313
%
% This file is part of Grey Wolf's Scouts Activity Template.
%
% Grey Wolf's Scouts Activity Template is free software: you can redistribute
% it and/or modify it under the terms of the GNU General Public License 
% as published by the Free Software Foundation, either version 3 of the
% License, or (at your option) any later version.
%
% Grey Wolf's Scouts Activity Template is distributed in the hope that it will
% be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
% of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Grey Wolf's Scouts Activity Template.  If not, see 
% <https://www.gnu.org/licenses/>.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{GreyWolfsScoutActivityTemplate}[2022/06/16 Grey Wolf Scout Activity Template]
\LoadClass[oneside]{article}
\NeedsTeXFormat{LaTeX2e}

%recognise utf8 in input files
\RequirePackage[utf8]{inputenc}

% We're going to do some sums with typesetting variables
\RequirePackage{calc}

% We're going to change from tim to time the spacing and presentation of section headings
\RequirePackage{titling}

% Import the font metrics from conversion to T1 by Mike Jones
\RequirePackage{NunitoSansOS2v3}

% Define a \HUGE font sixe for the Main Title 
\def\HUGE{\@setfontsize{\Huge}{60}{66}}%
\def\HUge{\@setfontsize{\Huge}{30}{32}}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Scout Branding Colours (Taken from Grey Wolf's Scout Beamer Template)
%
\RequirePackage{xcolor}

%Defined in General Branding Document
\definecolor{ScoutPurple}{HTML}{7413DC}
\definecolor{ScoutTest}{HTML}{7413DC}
\definecolor{ScoutTeal}{HTML}{00A794}
\definecolor{ScoutGreen}{HTML}{23a950}
\definecolor{ScoutRed}{HTML}{E22E12}
\definecolor{ScoutPink}{HTML}{FFB4E5}
\definecolor{ScoutNavy}{HTML}{003982}
\definecolor{ScoutBlue}{HTML}{006DDF}
\definecolor{ScoutYellow}{HTML}{FFE627}

\definecolor{ScoutBlack}{HTML}{000000}
\definecolor{ScoutWhite}{HTML}{FFFFFF}

% Defined in Branding Guide for Sections
\definecolor{ScoutNetwork}{HTML}{7413DC}
\definecolor{ScoutExplorers}{HTML}{7413DC}
\definecolor{ScoutScouts}{HTML}{004851} %This is a weird exception to the Branding Colours. Apparently allowed but only for Scouty-Scout Scouts.
\definecolor{ScoutCubs}{HTML}{23a950}
\definecolor{ScoutBeavers}{HTML}{006DDF}

% Use MarginNote primarily for Badges
\RequirePackage{marginnote}

% Set the geometry of the page layout some of these lengths are required for the placement of rules
\newlength{\activitymargin}\setlength{\activitymargin}{10mm}
\newlength{\activitymarginleft}\setlength{\activitymarginleft}{55mm}
\newlength{\activitymarginparsep}\setlength{\activitymarginparsep}{10mm}
\newlength{\activitymarginpar}\setlength{\activitymarginpar}{\activitymarginleft - \activitymargin - \activitymarginparsep}
\RequirePackage[
  margin=\activitymargin,
  left=\activitymarginleft,
  marginparwidth=\activitymarginpar,
  marginparsep=\activitymarginparsep,
  includehead,
  includefoot]{geometry}

% Use the Multicol package to control the 3 column areas of the template and set up lengths 
\RequirePackage{multicol}
\setlength{\columnsep}{5mm}

% Uncomment these three lines to make minipage and multicols left aligned 
%\RequirePackage{ragged2e}
%\AtBeginEnvironment{multicols}{\RaggedRight}
%\AtBeginEnvironment{minipage}{\RaggedRight}

% We need the Section counter to reset at the start of a part
\RequirePackage{chngcntr}
\counterwithin*{section}{part}

% Enable links
\RequirePackage{hyperref}
\hypersetup{pdfborder = {0 0 0},colorlinks,urlcolor=ScoutPurple,linkcolor=ScoutPurple}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load Icons for Creative Commons
% And create a licence macro
%
\RequirePackage{ccicons}
\newcommand{\thelicence}{\href{https://creativecommons.org/licenses/by-sa/4.0/}{\color{black} \ccbysa}}
\newcommand{\licence}[1]{\renewcommand{\thelicence}{#1}}

% Setup Header and Footer
\RequirePackage{fancyhdr}
\pagestyle{fancy}

\lhead{}
\chead{}
\rhead{Advice and Activities} % Not sure exactly why we need this vague header!
\lfoot{\href{https://twitter.com/search?q=\%23skillsforlife}{\color{black} \#SkillsForLife}}
\cfoot{\thelicence{} \theauthor}
\rfoot{\thepage}

% Calculate the length that is required to shift the left margin more left
% to arrive at \activitymargin
\newlength{\myoddoffset}
\setlength{\myoddoffset}{0pt}
\setlength{\myoddoffset}{\oddsidemargin + 1in - \activitymargin}

% Bump the header/footer left to start at \activitymargin
\fancyheadoffset[loh]{\myoddoffset}
\fancyheadoffset[lof]{\myoddoffset}

\renewcommand{\headrulewidth}{0pt} %Disable heading rule
\renewcommand{\footrulewidth}{1pt} %1pt for footer rule

% We will use textblocks for extra scout emblem on rolled over pages
% Specify units of 1mm on a coordnates based on top left of page.
\RequirePackage[absolute]{textpos}
  \setlength{\TPHorizModule}{1mm}
  \setlength{\TPVertModule}{1mm}

% Use xkeycal to allow key value pair options to macros 
\RequirePackage{xkeyval}

% Include the badges.tex file where the 
\RequirePackage{GreyWolfsScoutActivityBadges}

\RequirePackage{etoolbox}

% Lengths used to recalculate the height of the \part title
\newlength{\partheight}
\newlength{\partdepth}
\newsavebox{\partbox}

% The following is from Frank Mittelbach's answer
%https://tex.stackexchange.com/questions/89322/inserting-a-line-to-separate-the-text-and-the-margin-note#answer-89337
\patchcmd{\@outputpage}%
    {\box\@outputbox}%
    {\hbox{%
        \ifmpar@rule@lside
        \hskip-\mparrulefactor\marginparsep\mparrule
        \hskip\mparrulefactor\marginparsep
        \else\ifmpar@rule@rside\else\scoutlogopos\fi
        \fi
        \box\@outputbox
        \ifmpar@rule@rside
        \hskip\mparrulefactor\marginparsep\mparrule
        \fi}%
      \global\mpar@rule@lsidefalse
      \global\mpar@rule@rsidefalse
    }%
    {\typeout{*** SUCCESS ***}}{\typeout{*** FAIL ***}}
\patchcmd{\@addmarginpar}%
    {\global\setbox\@marbox\box\@currbox}%
    {\global\setbox\@marbox\box\@currbox
     \global\mpar@rule@lsidetrue
     \else
     \global\mpar@rule@rsidetrue
    }%
    {\typeout{*** SUCCESS ***}}{\typeout{*** FAIL ***}}

\newif\ifmpar@rule@lside
\newif\ifmpar@rule@rside

\newcommand\mparrule{%
  \textcolor{black}{%
    \hskip-.2pt{%
      \savebox{\partbox}{%
        \parbox{\textwidth+\myoddoffset}{%
          \HUGE\upshape\fontseries{ub}\selectfont\filright\strut\currentname\strut%
        }%
      }%
      \settoheight{\partheight}{\usebox{\partbox}}%
      \settodepth{\partdepth}{\usebox{\partbox}}%
      \rule[-\dimexpr\headsep-1\ht\strutbox\relax-1pt
      ]{0.5pt}{\paperheight-\partheight-\partdepth-72pt}% Hacky length perhaps from one inch perhaps I don't know
    }%
    \hskip-.2pt%
  }%
}
\newcommand\mparrulefactor{0.5}

%Insert a Scouts Stacked Fleur-de-lis top left (on non badge margin pages)
\newcommand\scoutlogopos{%
\begin{textblock}{4}(10,10)%
\includegraphics[width=\activitymarginpar]{logo-stacked-betterpurple-sansborder}%
\end{textblock}%
}

% The means to alter how section part and chapter headers are output
\RequirePackage{titlesec}


% This command formats the \part title into that of the Branding Activity Title
\titleformat{\part}          % section thing
  [display]                  % Normal
  {\color{ScoutPurple}\HUGE\upshape\fontseries{ub}\selectfont\filright}   % format
  {}      % label set to nothing as this template does not use part numbering NB Page 4 http://mirrors.ctan.org/macros/latex/contrib/titlesec/titlesec.pdf
  {0pt}% labelsep
  {}% beforecode
  [{\color{black}\titlerule}] %aftercode
  
% Titlespacing from page 5 of the titlesep docs
%\titlespacing{hcommandi}{hlefti}{hbefore-sepi}{hafter-sepi}[hright-sepi]
\titlespacing\part{-\myoddoffset}{-130pt}{20pt} %

% Basic title font formats for the general document 
\titleformat*{\section}{\normalfont\Large\bfseries\color{ScoutPurple}}
\titleformat*{\subsection}{\normalfont\large\bfseries\color{ScoutPurple}}
\titleformat*{\subsubsection}{\normalfont\normalsize\bfseries\color{black}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Every \part is a new page with all that entails
% Also set a macro to hold the name of the part;
% this is required to calculate spacing later.
\newcommand{\currentname}{@empty}
\let\oldpart\part% Store \part in \oldpart -- (done the \TeX way)
\renewcommand{\part}[2][]{\renewcommand{\currentname}{#2}\clearpage\oldpart[#1]{#2}}

% Put margin notes on the left
\reversemarginpar

% Define the \activitypart to add a margin to first page of \part
\newcommand{\activitypart}[2][]{
\part{#2}
\marginpar{\badgesidebyside[#1]}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Puts environment-content/stuff in a minibox left ~1/3 \textwidth;
% places an image in minibox right, ~3/2 \textwidth;
%
\newenvironment{SummaryImageBox}[1]%
{%
\ifvmode\else\newline\fi
\vspace{\baselineskip}
\def\SummaryBoxImage{#1}%
\begin{minipage}[t]{0.33\textwidth - 0.5\columnsep}
\strut\vspace*{-\baselineskip}\newline%
\titlespacing\section{0pt}{0pt}{-0.3\baselineskip}%
\titlespacing\subsection{0pt}{0pt}{-0.3\baselineskip}%
}%
{
\end{minipage}
%\ \hfill% Not sure why this stopped working without the space
\hspace{\columnsep}% Instead use specific hspace.
\begin{minipage}[t]{0.66\textwidth - 0.33\columnsep}
\strut\vspace*{-\baselineskip}\newline%
\includegraphics[width=\textwidth]{\SummaryBoxImage}
\end{minipage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Puts environment-content/stuff in a minibox left ~1/3 \textwidth;
% place other senvironment-content/stuff minibox right, ~3/2 \textwidth.
% Use \SummaryBoxSep to mark separation in environment.
%
\newif\ifSummaryBoxSep

\newcommand{\SummaryBoxSep}{%
\end{minipage}
\hfill
\begin{minipage}[t]{0.66\textwidth - 0.33\columnsep}
\titlespacing\section{0pt}{0pt}{-0.3\baselineskip}%
\titlespacing\subsection{0pt}{0pt}{-0.3\baselineskip}%
\SummaryBoxSeptrue
}
\newenvironment{SummaryBox}%
{%
\SummaryBoxSepfalse
\ifvmode\else\newline\fi
\vspace{\baselineskip}
\begin{minipage}[t]{0.33\textwidth - 0.5\columnsep}
\strut\vspace*{-\baselineskip}\newline%
\titlespacing\section{0pt}{0pt}{-0.3\baselineskip}%
\titlespacing\subsection{0pt}{0pt}{-0.3\baselineskip}%
}%
{%
\ifSummaryBoxSep\else% Remind command user to fill in right box
\SummaryBoxSep
Don't forget to use the {\tt \textbackslash{}SummaryBoxSep} command in the SummaryBox environment (Or consider using the \mbox{\tt \textbackslash{}SummaryImageBox\{\ldots\}} environment instead.)

\vspace{5mm}
\includegraphics[width=\textwidth]{fleur-de-lis-marque-betterpurple-sansborder}\\
\fi
\end{minipage}
}

% The ActivityProceedure environment.
% It's Basically a multicols environment with three columns with bells and whistles.
% Within the environment we change the title format for section/subsection 
% to fit the Scout Brand Centre's template better.
% We store the section counter for later use, before resetting it;
% we reset it so that numbered sections in this environment start at 1.
% To keep hyperref in check we store the current \theHsection and modify it
% to be a new label based on how many Activities have been called to this point.
\newcounter{preactivity}
\newcounter{activity}
\setcounter{activity}{0}
\newcommand{\hrefstate}{\theHsection}
\renewcommand*{\theHsection}{Activity.\the\value{activity}.\the\value{section}}

\newenvironment{ActivityProcedure}
{%
\renewcommand{\hrefstate}{\theHsection}
\renewcommand*{\theHsection}{\the\value{activity}.\the\value{section}}
\setcounter{preactivity}{\the\value{section}}
\setcounter{section}{0}
\stepcounter{activity}
\ifvmode\else\newline\vspace{-\baselineskip}\fi
\begingroup%
\titleformat*{\section}{\normalfont\HUge\fontseries{ub}\selectfont\color{ScoutPurple}}%
\titlespacing\section{0pt}{0pt}{-0.3\baselineskip}%
\titleformat*{\subsection}{\normalfont\large\fontseries{ub}\selectfont\color{ScoutPurple}}
\titlespacing\subsection{0pt}{0pt}{0pt}%
\begin{multicols}{3}}
{
\end{multicols}
\endgroup
\setcounter{section}{\the\value{preactivity}}
\renewcommand*{\theHsection}{\hrefstate}
}

% The Sections[] command lists matching sections specified in the argument,
% in section order, and presents them as a string in an unnumbered section heading 
\newif\ifsection@squirrels
\newif\ifsection@beavers
\newif\ifsection@cubs
\newif\ifsection@scouts
\newif\ifsection@explorers
\newif\ifsection@network
\define@key{section}{squirrels}[true]{\csname section@squirrels#1\endcsname}
\define@key{section}{beavers}[true]{\csname section@beavers#1\endcsname}
\define@key{section}{cubs}[true]{\csname section@cubs#1\endcsname}
\define@key{section}{scouts}[true]{\csname section@scouts#1\endcsname}
\define@key{section}{explorers}[true]{\csname section@explorers#1\endcsname}
\define@key{section}{network}[true]{\csname section@network#1\endcsname}
\newcommand\Sections[1][]{
  \setkeys{section}{squirrels=false,beavers=false,cubs=false,scouts=false,explorers=false,network=false}
  \setkeys{section}{#1}
  \section*{%
    \ifsection@squirrels{} / Squirrels\fi%
    \ifsection@beavers{} / Beavers\fi%
    \ifsection@cubs{} / Cubs\fi%
    \ifsection@scouts{} / Scouts\fi%
    \ifsection@explorers{} / Explorers\fi%
    \ifsection@network{} / Network\fi{} /%
  }
}

% Macro to return a Time 30 minutes string as an unnumbered subsection header
\newcommand{\sessiontime}[1][30 minutes]{%
\begingroup%
\titlespacing\subsection{0pt}{-0.3\baselineskip}{5pt}%
\subsection*{Time #1}
\endgroup
}

% Make a text square using \framebox_(picture)
\newcommand{\equip}[1]{%
\begingroup%
\setlength{\unitlength}{1pt}%
#1~\dotfill~\framebox(10,10){}\\%
\endgroup%
}

% no indents for paragraphs
\parindent=0pt