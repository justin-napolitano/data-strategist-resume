\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cover-letter-class}[2024/07/22 cover-letter-class v0.1]

\DeclareOption{singlesided}{\setboolean{@singleordouble}{true}}
\DeclareOption{doublesided}{\setboolean{@singleordouble}{false}}

\ProcessOptions*

\LoadClass{scrartcl}

\RequirePackage{ifthen}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{fontawesome}
\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{academicons}
\RequirePackage{xpatch}
\RequirePackage{scrlayer-scrpage}
\RequirePackage{hyperref}
\RequirePackage[inline]{enumitem}
\RequirePackage[bindingoffset=0cm,nomarginpar,noheadfoot]{geometry}
\RequirePackage{fix-cm}

\newlength\highlightwidth
\newlength\headerheight
\newlength\marginleft
\newlength\marginright
\newlength\margintop
\newlength\marginbottom

\setlength\highlightwidth{8cm}
\setlength\headerheight{3cm}
\setlength\marginleft{1cm}
\setlength\marginright{\marginleft}
\setlength\margintop{1cm}
\setlength\marginbottom{1cm}

\geometry{left=\marginleft,right=\marginright,top=\margintop,bottom=\marginbottom}

\definecolor{headerfontcolor}{HTML}{000000}
\definecolor{red}{HTML}{FF0000} % Example accent color

% Gray-scale colors
\definecolor{white}{HTML}{FFFFFF}
\definecolor{darkgray}{HTML}{333333}
\definecolor{mediumgray}{HTML}{444444}
\definecolor{gray}{HTML}{5D5D5D}
\definecolor{lightGray}{HTML}{D3D3D3}
% Basic colors
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{blue}{HTML}{6CE0F1}
% Text colors
\definecolor{darktext}{HTML}{414141}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
% Awesome colors
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}

% font sizes

% \makeatletter 
\newcommand\semiHuge{\@setfontsize\semiHuge{22.72}{27.38}}
\newcommand\semihuge{\@setfontsize\semihuge{18.93}{23.45}}
\newcommand\semiLARGE{\@setfontsize\semiLARGE{15.77}{19.90}}
\newcommand\semiLarge{\@setfontsize\semiLarge{13.15}{15.87}}% 15.18?
\newcommand\semilarge{\@setfontsize\semilarge{11.46}{13.80}}
\newcommand\seminormal{\@setfontsize\seminormal{10.46}{12.77}}
% \makeatother 

\setlength{\parindent}{0pt}
\setlength{\parskip}{0.5em}

% Header Command Definitions
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\jobtitle}[1]{\def\@jobtitle{#1}}
\newcommand{\photo}[3][]{\def\@photo{#2}\def\@photodiameter{#3}\def\@photoformat{#1}}
\newcommand{\contactinfo}[1]{\def\@contactinfo{#1}}

\newlength{\@namefontheight}
\newlength{\@namelineheight}
\settoheight{\@namefontheight}{\large\bfseries\MakeUppercase{A}}
\setlength\@namelineheight{1\@namefontheight}

\lehead[]{}
\cehead[]{}
\rehead[]{}
\lohead[]{}
\cohead[]{}
\rohead[]{}
\lefoot[]{}
\cefoot[]{}
\refoot[]{}
\lofoot[]{}
\cofoot[]{}
\rofoot[]{}

% Header with job title and contact information
\newcommand{\alignedheader}[2][]{%
    \ifthenelse{\equal{#2}{center}}{%
        \begin{center}
            {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
            \vspace{0.5em}
            {\semiLarge\color{headerfontcolor}\@jobtitle\par}
            \vspace{0.5em}
            {\small\color{headerfontcolor}\@contactinfo\par}
        \end{center}
    }{%
        \ifthenelse{\equal{#2}{left}}{%
            \begin{minipage}[c]{\dimexpr \textwidth - \@ifundefined{\@photo}{0}{\@photodiameter} + 0.5em\relax}
                \begin{flushleft}
                    {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
                    \vspace{0.5em}
                    {\large\color{headerfontcolor}\@jobtitle\par}
                    \vspace{0.5em}
                    {\small\color{headerfontcolor}\@contactinfo\par}
                \end{flushleft}
            \end{minipage}%
            \ifdefined\@photo
                \hfill
                \begin{minipage}[c]{\@photodiameter}%
                    \ifthenelse{\equal{#1}{square}}{%
                        \includegraphics[width=\@photodiameter]{\@photo}%
                    }{%
                        \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5*\@photodiameter];
                    }
                \end{minipage}%
            \fi
        }{%
            \ifthenelse{\equal{#2}{right}}{%
                \ifdefined\@photo
                    \begin{minipage}[c]{\@photodiameter}%
                        \ifthenelse{\equal{#1}{square}}{%
                            \includegraphics[width=\@photodiameter]{\@photo}%
                        }{%
                            \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5*\@photodiameter];
                        }
                    \end{minipage}%
                    \hfill
                \fi
                \begin{minipage}[c]{\dimexpr \textwidth - \@ifundefined{\@photo}{0}{\@photodiameter} + 0.5em\relax}
                    \begin{flushright}
                        {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
                        \vspace{0.5em}
                        {\large\color{headerfontcolor}\@jobtitle\par}
                        \vspace{0.5em}
                        {\small\color{headerfontcolor}\@contactinfo\par}
                    \end{flushright}
                \end{minipage}%
            }{}
        }
    }
}

% Contact Information Command Definitions
\newcommand{\infofield}[2]{\makebox[5mm]{\textcolor{red}{\normalsize #1}}\hspace{0.5em}#2}
\newcommand{\email}[1]{\infofield{\faEnvelope}{\href{mailto:#1}{#1}}}
\newcommand{\phone}[1]{\infofield{\faPhone}{#1}}
\newcommand{\linkedin}[2]{\infofield{\faLinkedin}{\href{#2}{#1}}}
\newcommand{\github}[2]{\infofield{\faGithub}{\href{#2}{#1}}}

% Body
\newcommand{\mainbody}[1]{%
    \begin{minipage}[t]{\textwidth}%
        #1%
    \end{minipage}%
}

\endinput
