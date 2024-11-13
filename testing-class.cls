%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my-resume.cls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A class to do stuff.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my-resume}[2020/11/17 my-resume v0.1, my own resume/CV class.]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLASS OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% option to have a single sided document, i.e. the highlight bar is always left
% or have a two sided document where the highlight bar is alternating, i.e. always on the same edge of the paper
\RequirePackage{ifthen}
\newboolean{@singleordouble}
\setboolean{@singleordouble}{true}
\DeclareOption{singlesided}{\setboolean{@singleordouble}{true}}
\DeclareOption{doublesided}{\setboolean{@singleordouble}{false}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions*

\ifthenelse{\boolean{@singleordouble}}
    {\PassOptionsToClass{oneside}{scrartcl}}
    {\PassOptionsToClass{twoside}{scrartcl}}

\LoadClass{scrartcl}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REQUIRED PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}       % somehow required for tikz to work at all
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{fontawesome}
\RequirePackage{academicons}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILTER IRRELEVANT WARNINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{silence}

% The page header is deliberately disabled in my-resume, so the warning by scrlayer-scrpage is invalid. 
\WarningFilter{scrlayer-scrpage}{Very small head height detected!}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE GEOMETRY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength\highlightwidth
\newlength\headerheight
\newlength\marginleft
\newlength\marginright
\newlength\margintop
\newlength\marginbottom

% default sizes, margins, ...
\setlength\highlightwidth{8cm}
\setlength\headerheight{2cm}  % Adjusted header height
\setlength\marginleft{1cm}
\setlength\marginright{\marginleft}
\setlength\margintop{0.5cm}
\setlength\marginbottom{1cm}

\RequirePackage[bindingoffset=0cm,nomarginpar,noheadfoot]{geometry}
\geometry{left=\marginleft,right=\marginright,top=\margintop,bottom=\marginbottom}

% minipage has an annoying af indent that must be removed
\setlength{\parindent}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xcolor}

% Gray-scale colors
\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{darkgray}{HTML}{333333}
\definecolor{mediumgray}{HTML}{444444}
\definecolor{gray}{HTML}{5D5D5D}
\definecolor{lightGray}{HTML}{D3D3D3}
% Basic colors
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}
% Text colors
\definecolor{darktext}{HTML}{414141}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
% Awesome colors
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-green}{HTML}{49796B}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}
\definecolor{light-red}{HTML}{F17E68}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORED BARS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xpatch}
\RequirePackage{scrlayer-scrpage}

% declare new page style using layers
\DeclareNewPageStyleByLayers{headerhighlightmain}{%
  highlightbar.even,%
  highlightbar.odd,%
  header.bg
}
\DeclareNewPageStyleByLayers{highlightmain}{%
  highlightbar.even,%
  highlightbar.odd
}
\DeclareNewPageStyleByLayers{headermain}{%
  header.bg
}

% define the layer for the highlight bar on odd pages
\DeclareNewLayer[
  background,
  oddpage,
  innermargin,
  width=\highlightwidth,
  contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
]{highlightbar.odd}

% clone highlight bar form odd pages to even pages
% on same side for digital format
\newcommand*\highlightbarsingle{%
\DeclareNewLayer[
  background,
  evenpage,
  outermargin,
  width=\highlightwidth,
  contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
]{highlightbar.even}
}

% clone highlight bar from odd pages to even pages
% on opposite sides for prints
\newcommand*\highlightbardouble{%
\DeclareNewLayer[
    clone=highlightbar.odd,
    evenpage,
    align=r,
    hoffset=\paperwidth
  ]{highlightbar.even}
 }

% use the correct version of the highlight bar on even pages
% single for single, double for double
\ifthenelse{
    \boolean{@singleordouble}
}{%
    \DeclareNewLayer[
      background,
      evenpage,
      outermargin,
      width=\highlightwidth,
      contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
    ]{highlightbar.even}
}{%
    \DeclareNewLayer[
        clone=highlightbar.odd,
        evenpage,
        align=r,
        hoffset=\paperwidth
      ]{highlightbar.even}
}

% define the layer for the header 
\DeclareNewLayer[
  background,
  topmargin,
  addheight=\headerheight,
  contents={\color{headerbarcolor}\rule{\layerwidth}{\layerheight}}
]{header.bg}

% % add the layers to page style plain
% \ForEachLayerOfPageStyle*{headerhighlightmain}{%
%   \AddLayersToPageStyle{plain.scrheadings}{#1}%
% }

% remove anything that might be there (page number) from header and footer
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% variables for name, tag line and photo setup
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[3][]{\def\@photo{#2}\def\@photodiameter{#3}\def\@photoformat{#1}}

% try to align the top of the written out name with the top of the photo
% it is impossible to get the actual height of a line to determine the offset between line top and charachter top
% therefore use a bad workaround by setting the line height to 1.5 times the character height
\newlength{\@namefontheight}
\newlength{\@namelineheight}
\settoheight{\@namefontheight}{\large\bfseries\MakeUppercase{A}}
\setlength\@namelineheight{1\@namefontheight}

% Define a new header to center the name at the top of the page
\newcommand{\centeredheader}{%
    \begin{center}
        {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
        \ifdefined\@tagline
            \vspace{0.5em}
            {\large\color{headerfontcolor}\@tagline\par}
        \fi
    \end{center}
}

% Define a new header to align the name and tagline based on the argument
\newcommand{\alignedheader}[1]{%
    \ifthenelse{\equal{#1}{center}}{%
        \begin{center}
            {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
            \ifdefined\@tagline
                \vspace{0.5em}
                {\large\color{headerfontcolor}\@tagline\par}
            \fi
        \end{center}
    }{%
        \ifthenelse{\equal{#1}{left}}{%
            \begin{flushleft}
                {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
                \ifdefined\@tagline
                    \vspace{0.5em}
                    {\large\color{headerfontcolor}\@tagline\par}
                \fi
            \end{flushleft}
        }{%
            \begin{flushright}
                {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
                \ifdefined\@tagline
                    \vspace{0.5em}
                    {\large\color{headerfontcolor}\@tagline\par}
                \fi
            \end{flushright}
        }
    }
}

% Define a new header to align the name, tagline, and optionally a photo based on the alignment argument
% Define a new header to align the name, tagline, and optionally a photo based on the alignment argument
% Define a new header to align the name, tagline, and optionally a photo based on the alignment argument
% Define a new header to align the name, tagline, and optionally a photo based on the alignment argument
% Define a new header to align the name, tagline, and optionally a photo based on the alignment argument
\newcommand{\alignedheadertest}[2][]{%
    \ifthenelse{\equal{#2}{center}}{%
        \begin{center}
            {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
            \ifdefined\@tagline
                \vspace{0.5em}
                {\large\color{headerfontcolor}\@tagline\par}
            \fi
        \end{center}
    }{%
        \ifthenelse{\equal{#2}{left}}{%
            \begin{minipage}[c]{\dimexpr \textwidth - \ifdefined\@photo\@photodiameter + 0.5em\fi}
                \begin{flushleft}
                    {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
                    \ifdefined\@tagline
                        \vspace{0.5em}
                        {\large\color{headerfontcolor}\@tagline\par}
                    \fi
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
                \begin{minipage}[c]{\dimexpr \textwidth - \ifdefined\@photo\@photodiameter + 0.5em\fi}
                    \begin{flushright}
                        {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
                        \ifdefined\@tagline
                            \vspace{0.5em}
                            {\large\color{headerfontcolor}\@tagline\par}
                        \fi
                    \end{flushright}
                \end{minipage}%
            }{}
        }
    }
}

% Usage:
% To use this header, call \alignedheader[square]{center}, \alignedheader[square]{left}, or \alignedheader[square]{right} where appropriate in your document.



% Usage:
% To use this header, call \alignedheader[square]{center}, \alignedheader[square]{left}, or \alignedheader[square]{right} where appropriate in your document.

% Usage:
% To use this header, call \alignedheader[square]{center}, \alignedheader[square]{left}, or \alignedheader[square]{right} where appropriate in your document.


% Usage:
% To use this header, call \alignedheader[square]{center}, \alignedheader[square]{left}, or \alignedheader[square]{right} where appropriate in your document.


% Define a new header to align the name, tagline, and photo based on the argument
\newcommand{\alignedheaderimage}[2][]{%
    \ifthenelse{\equal{#2}{center}}{%
        \begin{center}
            \ifdefined\@photo
                \ifthenelse{\equal{#1}{square}}{%
                    \includegraphics[width=\@photodiameter]{\@photo}\par
                }{%
                    \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\@photodiameter];
                }
                \vspace{0.5em}
            \fi
            {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
            \ifdefined\@tagline
                \vspace{0.5em}
                {\large\color{headerfontcolor}\@tagline\par}
            \fi
        \end{center}
    }{%
        \ifthenelse{\equal{#2}{left}}{%
            \begin{flushleft}
                \ifdefined\@photo
                    \ifthenelse{\equal{#1}{square}}{%
                        \includegraphics[width=\@photodiameter]{\@photo}\par
                    }{%
                        \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\@photodiameter];
                    }
                    \vspace{0.5em}
                \fi
                {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
                \ifdefined\@tagline
                    \vspace{0.5em}
                    {\large\color{headerfontcolor}\@tagline\par}
                \fi
            \end{flushleft}
        }{%
            \begin{flushright}
                \ifdefined\@photo
                    \ifthenelse{\equal{#1}{square}}{%
                        \includegraphics[width=\@photodiameter]{\@photo}\par
                    }{%
                        \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\@photodiameter];
                    }
                    \vspace{0.5em}
                \fi
                {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
                \ifdefined\@tagline
                    \vspace{0.5em}
                    {\large\color{headerfontcolor}\@tagline\par}
                \fi
            \end{flushright}
        }
    }
}

% Usage:
% To use this header, call \alignedheader[square]{center}, \alignedheader[square]{left}, or \alignedheader[square]{right} where appropriate in your document.


% Usage:
% To use this header, call \alignedheader{center}, \alignedheader{left}, or \alignedheader{right} where appropriate in your document.


% assemble the header
\newcommand{\makeheader}{% header bar is a minipage
    \begin{minipage}[t][\headerheight]{\textwidth}%
        % create two minipages for header text and photo if photo is given
        \ifdef{\@photodiameter}{
            \begin{minipage}[t]{\dimexpr \textwidth-\@photodiameter}        % to top align name and photo add [t] here
                \vspace{0cm}%
            }{}
            % print the header text
                \begin{minipage}[t][2em]{\linewidth}
                    {\huge\color{headerfontcolor}\MakeUppercase{\@name}\par}
                \end{minipage}%
                \vfill%
                \ifdefined\@tagline
                \begin{minipage}[b][\dimexpr \headerheight-2em]{\linewidth}%
                    {\large\color{headerfontcolor}\@tagline\par}
                \end{minipage}%
                \fi
        % finish the minipages for text and photo if photo is given
        \ifdef{\@photodiameter}{%
            \end{minipage}\hfil%
            \begin{minipage}[t]{\@photodiameter}                                % to top align name and photo add [t] here
                \vspace{0cm}
                % format as square or round
                \ifthenelse{\equal{\@photoformat}{square}}{%
                    \includegraphics[width=\linewidth]{\@photo}%
                }{%
                    \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\linewidth];
                }
            \end{minipage}%
            }{}
    \end{minipage}%
}

% Optional: Adjust the spacing below the header
\setlength{\parskip}{0pt} % set the paragraph skip length to 0pt
\setlength{\parindent}{0pt} % set the paragraph indentation to 0pt

\newcommand{\emptyheader}{%
    \vspace*{\dimexpr \headerheight+0.5em}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BODY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% contact info
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\infofield}[2]{\mbox{\makebox[5mm]{\textcolor{accent}{\normalsize #1}}\hspace{0.5em}#2}\vspace{0.2em}\newline}
\newcommand{\email}[1]{\infofield{\faEnvelope}{\href{mailto:#1}{#1}}}
\newcommand{\address}[1]{\infofield{\faAt}{#1}}
\newcommand{\location}[1]{\infofield{\faMapMarker}{#1}}
\newcommand{\phone}[1]{\infofield{\faPhone}{#1}}
\newcommand{\homepage}[2]{\infofield{\faHome}{\href{#2}{#1}}}
\newcommand{\linkedin}[2]{\infofield{\faLinkedin}{\href{#2}{#1}}}
\newcommand{\github}[2]{\infofield{\faGithub}{\href{#2}{#1}}}
\newcommand{\orcid}[2]{\infofield{\aiOrcid}{\href{#2}{#1}}}
\newcommand{\ads}[2]{\infofield{\aiADS}{\href{#2}{#1}}}

% highlight bar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\highlightbar}[1]{%
    \def\@highlightbar{%
        \begin{minipage}[t]{\dimexpr \highlightwidth-\marginleft-\marginright}%
            #1%
        \end{minipage}%
    }
}

% main bar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\mainbar}[1]{%
    \def\@mainbar{%
        \begin{minipage}[t]{\dimexpr \textwidth-\highlightwidth}%
            #1%
        \end{minipage}%
    }
}

% make body with highlight bar and main bar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makebody}{%
    \ifthenelse{\boolean{@singleordouble}}
        {% if single layout, the highlight bar is always left
            \@highlightbar
            % \hspace{\dimexpr \marginleft+\marginright}%
            \hspace{.75cm}%
            \@mainbar
        }{% if double layout, the highlight bar alternates
            \Ifthispageodd{% if the page is odd, the highlight bar is on the left (as is for single layout)
                \@highlightbar
                \hspace{\dimexpr 1em +\marginleft+\marginright}%
                \@mainbar
            }{%  if the page is even, the highlight bar is on the right
                \@mainbar
                \hspace{\dimexpr 1em \marginleft+\marginright}%
                \@highlightbar
            }   
        }
}

% \newcommand{\makebody}{%
%     \ifthenelse{\boolean{@singleordouble}}
%         {% Single layout logic: highlight bar on the left
%             \begin{minipage}[t]{\highlightwidth}
%                 \@highlightbar
%             \end{minipage}%
%             \hspace{0.75cm}% Adjust spacing as needed
%             \begin{minipage}[t]{\dimexpr \textwidth - \highlightwidth}
%                 % \raggedright
%                 \@mainbar
%             \end{minipage}
%         }
%         {% Double layout logic: highlight bar alternates
%             \Ifthispageodd{% Odd pages: highlight bar on the left
%                 \begin{minipage}[t]{\highlightwidth}
%                     \@highlightbar
%                 \end{minipage}%
%                 \hspace{\dimexpr \marginleft + \marginright}%
%                 \begin{minipage}[t]{\dimexpr \textwidth - \highlightwidth}
%                     % \raggedright
%                     \@mainbar
%                 \end{minipage}
%             }{% Even pages: highlight bar on the right
%                 \begin{minipage}[t]{\dimexpr \textwidth - \highlightwidth}
%                     % \raggedleft
%                     \@mainbar
%                 \end{minipage}%
%                 \hspace{\dimexpr \marginleft + \marginright}%
%                 \begin{minipage}[t]{\highlightwidth}
%                     \@highlightbar
%                 \end{minipage}
%             }
%         }
% }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTIONS, SUBSECTIONS, AND MORE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SUBTEXT
\newcommand{\subtext}[1]{\footnotesize\textit{#1}\par\vspace{.5em}}

% redefine section in caps, bold and with rule below
\renewcommand{\section}[2][]{%
    % \bigskip%
    % \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr 1pt-\baselineskip}\raggedright\input{#1}}}%
    \ifstrequal{#1}{}{}{\makebox[5mm][c]{#1}\hspace{0.5em}}
    {\color{heading}\small\bfseries\MakeUppercase{#2}}\\[-1ex]%
    {\color{heading}\rule{\linewidth}{1.0pt}\par}
}

% redefine subsection as bold
\renewcommand{\subsection}[1]{%
  \smallskip%
  {\color{emphasis}\small\bfseries{#1}\par} \smallskip
}

% format job/school list
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set length of date/place column versus position column in fraction of linewidth before linewidth gets redefined in minipages
\newlength{\jobdateplacelength}
\newlength{\jobpositionlength}
\setlength{\jobdateplacelength}{0.4\linewidth}
\setlength{\jobpositionlength}{0.6\linewidth}
\newcommand{\job}[5]{%
    \begin{minipage}[t]{\jobdateplacelength}% minipage for left column with date/place
        \large
        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line dates
            \makebox[3mm][c]{\faGear}
        \end{minipage}%
        \hspace{0.5em}%
           {\large \color{emphasis} #1}
%        \begin{minipage}[t][3mm]{\jobpositionlength}% minipage for position
%            {\large \color{emphasis} #3}
%        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% wrap date in minipage to allow multi-line dates
%            #1
%        \end{minipage}%
        \par
        \vspace{0.1em}
        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line places
            \footnotesize \makebox[3mm][c]{}%\faBuilding}
        \end{minipage}%
        \hspace{0.5em}%
        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% wrap place in minipage to allow multi-line places
            \footnotesize #2
        \end{minipage}%i
    \end{minipage}%
        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% wrap date in minipage to allow multi-line dates
        \hspace{0.5em}%
        \normalsize #3
            
%        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% minipage for position 
 %           \makebox[3mm][c]{\footnotesize  #4} %\faMapMarker} #4
 %       \end{minipage}%
        \hspace{5em}%
        \footnotesize   #4 %city location
    \end{minipage}%
    \ifstrequal{#4}{}{}{
%        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line dates
        %\par 
        \vspace{0.5em} \hspace{0em} \footnotesize #5
%    \end{minipage}
    }
    %\par \vspace{0.1em} \footnotesize #4}
%\par\normalsize
%\vspace{0.5em}\par \vspace{0.1em} \footnotesize #4}
    \par \normalsize
    \vspace{0.25em}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Education
\newcommand{\education}[4]{%
    \begin{minipage}[t]{\jobdateplacelength}% minipage for left column with date/place
        \footnotesize
        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line dates
            \makebox[3mm][c]{\faCertificate}
        \end{minipage}%
        \hspace{0.5em}%
           {\large \color{emphasis} #3}
%        \begin{minipage}[t][3mm]{\jobpositionlength}% minipage for position
%            {\large \color{emphasis} #3}
%        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% wrap date in minipage to allow multi-line dates
%            #1
%        \end{minipage}%
        \par
        \vspace{0.1em}
        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line places
            \makebox[3mm][c]{\faMapMarker}
        \end{minipage}%
        \hspace{0.5em}%
        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% wrap place in minipage to allow multi-line places
            #2
        \end{minipage}%i
    \end{minipage}%
        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% wrap date in minipage to allow multi-line dates
            \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line dates
                \makebox[3mm][c]{\faCalendar}
            \end{minipage}%
            \hspace{0.5em}%
            #1
%    \begin{minipage}[t]{\jobpositionlength}% minipage for position
%        {\large \color{emphasis} #3}
    \end{minipage}%
    \ifstrequal{#4}{}{}{
%        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line dates
        %\par 
        \vspace{0.5em} \hspace{0em} \footnotesize  #4
%    \end{minipage}
    }
    %\par \vspace{0.1em} \footnotesize #4}
%\par\normalsize
%\vspace{0.5em}\par \vspace{0.1em} \footnotesize #4}
    \par\normalsize
    \vspace{0.5em}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Project Similiar to job but with different Icons
\newlength{\projectdateplacelength}
\newlength{\projectpositionlength}
\setlength{\projectdateplacelength}{0.4\linewidth}
\setlength{\projectpositionlength}{0.6\linewidth}
\newcommand{\project}[3]{%
    \begin{minipage}[t]{\projectdateplacelength}% minipage for left column with date/place
        \footnotesize
        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line dates
            \makebox[3mm][c]{\faCube}
        \end{minipage}%
        \hspace{0.5em}%
           {\large \color{emphasis} #2}
%        \begin{minipage}[t][3mm]{\jobpositionlength}% minipage for position
%            {\large \color{emphasis} #3}
%        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% wrap date in minipage to allow multi-line dates
%            #1
%        \end{minipage}%
        \par
        \vspace{0.1em}
    \end{minipage}%
        \begin{minipage}[t]{\dimexpr \projectdateplacelength-3mm-0.5em}% wrap date in minipage to allow multi-line dates
            \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line dates
                \makebox[3mm][c]{\faCalendar}
            \end{minipage}%
            \hspace{0.5em}%
            #1
%    \begin{minipage}[t]{\jobpositionlength}% minipage for position
%        {\large \color{emphasis} #3}
    \end{minipage}%
    \ifstrequal{#3}{}{}{
%        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line dates
        %\par 
        \vspace{0.5em} \hspace{0em} \footnotesize  #3
%    \end{minipage}
    }
    %\par \vspace{0.1em} \footnotesize #4}
%\par\normalsize
%\vspace{0.5em}\par \vspace{0.1em} \footnotesize #4}
    \par\normalsize
    \vspace{0.5em}
}

% skill with 5 dot bar chart
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\skillest}[2]{%
    \textcolor{emphasis}{\textbf{#1}}\hfill
    \textcolor{emphasis}{\textbf{#2}}
    }
\newcommand{\skill}[2]{%
    {\small % Reduces the font size
    \textcolor{emphasis}{{#1}}\hfill
    \foreach \x in {1,...,5}{%
      \space{\ifnumgreater{\x}{#2}{\color{gray}}{\color{accent}}\scalebox{0.8}{\faCircle}}}\par% Adjust the scaling factor as needed
    \vspace{0.2em}% Adjust the vertical space here
    }
}



% skill without any charts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\simpleskill}[1]{%
    \textcolor{emphasis}{\textbf{#1}}\par%
}

% sectioning of skills
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\skillsection}[1]{%
    {\small\textit{\color{accent}#1}}\par
}

% tag (framed word or phrase)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% adapted from AltaCV: https://github.com/liantze/AltaCV
\newcommand{\tag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}

% wheel chart
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% adapted from AltaCV: https://github.com/liantze/AltaCV
\newcommand{\wheelchart}[4][0]{%
    \begingroup\centering
    \def\innerradius{#3}%
    \def\outerradius{#2}%
    % Calculate total
    \pgfmathsetmacro{\totalnum}{0}%
    \foreach \value/\colour/\name in {#4} {%
        \pgfmathparse{\value+\totalnum}%
        \global\let\totalnum=\pgfmathresult%
    }%
    \begin{tikzpicture}

      % Calculate the thickness and the middle line of the wheel
      \pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
      \pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}
      \pgfmathsetmacro{\totalrot}{-90 + #1}

      % Rotate so we start from the top
      \begin{scope}[rotate=\totalrot]

      % Loop through each value set. \cumnum keeps track of where we are in the wheel
      \pgfmathsetmacro{\cumnum}{0}
      \foreach \value/\width/\colour/\name in {#4} {
            \pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}

            % Calculate the percent value
            \pgfmathsetmacro{\percentage}{\value/\totalnum*100}
            % Calculate the mid angle of the colour segments to place the labels
            \pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}

            % This is necessary for the labels to align nicely
            \pgfmathparse{
               (-\midangle>180?"west":"east")
            } \edef\textanchor{\pgfmathresult}
            \pgfmathparse{
               (-\midangle>180?"flush left":"flush right")
            } \edef\textalign{\pgfmathresult}
            \pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}

            % Draw the color segments. Somehow, the \midrow units got lost, so we add 'pt' at the end. Not nice...
            \filldraw[draw=white,fill=\colour] (-\cumnum:\outerradius) arc (-\cumnum:-(\newcumnum):\outerradius) --
            (-\newcumnum:\innerradius) arc (-\newcumnum:-(\cumnum):\innerradius) -- cycle;

            % Draw the data labels
            \draw  [*-,thin,emphasis] node [append after command={(\midangle:\midradius pt) -- (\midangle:\outerradius + 1ex) -- (\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [xshift=\labelshiftdir*0.5cm,inner sep=1ex, outer sep=0pt, text width=\width,anchor=\textanchor,align=\textalign,font=\small,text=body]{\name};
            % Set the old cumulated angle to the new value
            \global\let\cumnum=\newcumnum
        }
      \end{scope}
%      \draw[gray] (0,0) circle (\outerradius) circle (\innerradius);
    \end{tikzpicture}\par
    \endgroup
}

% publication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\ADS}[1]{\textcolor{awesome-skyblue}{\href{#1}{ADS}}}
\newcommand*{\arXiv}[1]{\textcolor{awesome-skyblue}{\href{#1}{arXiv}}}
\newcommand*{\doi}[2]{\textcolor{awesome-skyblue}{\href{#2}{#1}}}

\newlength{\pubdatelength}
\newlength{\pubjournallength}
\newlength{\publinklength}

% Spacings work erratically. Setting a highlight bar or not redefines \linewidth in a weird way which breaks the spacing and introduces line breaks. I have no idea what exactly causes this problem.

% helper function to set spacings that work empirically
\newcommand{\pubdefaultspacing}{%
    \setlength{\pubdatelength}{0.15\linewidth}
    \setlength{\pubjournallength}{0.65\linewidth}
    \setlength{\publinklength}{0.20\linewidth}
}

% helper function to force the publication to use the full width in normal page styles without highlight bar or header
\newcommand{\pubforcefullwidth}{%
    \setlength{\pubdatelength}{0.1\textwidth}
    \setlength{\pubjournallength}{0.80\textwidth}
    \setlength{\publinklength}{0.1\textwidth}
}

% \pubforcefullwidth
\pubdefaultspacing

\newcommand{\publication}[5]{%
    {\normalsize \color{emphasis}#1\par}
    \vspace{0.1em}%
    \begin{minipage}[t]{3mm}%
        \makebox[3mm][c]{\footnotesize \faGroup}
    \end{minipage}%
    \hspace{0.5em}%
    \begin{minipage}[t]{\dimexpr \linewidth-3mm-0.5em}%
        {\footnotesize #2\par}
    \end{minipage}%
    \par%
    \vspace{0.25em}%
    \ifstrequal{#4}{}{%
        \begin{minipage}[t]{\dimexpr \pubdatelength+\pubjournallength-1.0em}%
            \footnotesize \makebox[3mm][c]{\faCalendar} \hspace{0.25em} #3
        \end{minipage}%
    }{%
        \begin{minipage}[t]{\dimexpr \pubdatelength-1.0em}%
            \footnotesize \makebox[3mm][c]{\faCalendar} \hspace{0.25em} #3
        \end{minipage}%
    }%
    \hspace{1.0em}
    \begin{minipage}[t]{\dimexpr \pubjournallength-1.0em}%
        \ifstrequal{#4}{}{}{%
            \begin{minipage}[t]{3mm}%
                \makebox[3mm][c]{\footnotesize \faBook}
            \end{minipage}%
            \hspace{0.5em}%
            \begin{minipage}[t]{\dimexpr \linewidth-3mm-0.25em}%
                {\footnotesize #4\par}
            \end{minipage}%
        }%
    \end{minipage}%
    \hspace{1.0em}
    \begin{minipage}[t]{\publinklength}%
        \ifstrequal{#5}{}{}{%
            \footnotesize \makebox[3mm][c]{\faChain} \hspace{0.25em} #5\par
        }%
    \end{minipage}%
    \par\normalsize
    \vspace{1.0em}
}

\newcommand{\justinpublication}[4]{
    \subsection{{#1}}
    \vspace{0.2em}
    \par%
    \subtext{\faBook \hspace{.5em} #3}
    \vspace{0.2em}
    \subtext{\faGroup \hspace{.5em} #2}
    \vspace{0.2em}
    \subtext{\faChain \hspace{.5em} #4}
    \vspace{0.2em}
    % \subtext{\faCalendar \hspace{.5em} #3 }
    % \hfill \faChain \hspace{.5em} #5}
    
    \par%

}
\newcommand{\publicationSmall}[5]{%
    {\normalsize \color{emphasis}#1\par}
    \vspace{0.1em}%
    \begin{minipage}[t]{3mm}%
        \makebox[3mm][c]{\footnotesize \faGroup}
    \end{minipage}%
    \hspace{0.5em}%
    \normalsize #2
%    \begin{minipage}[t]{\dimexpr \linewidth-3mm-0.5em}%
%        {\footnotesize #2\par}
%    \end{minipage}%
    \par%
    \vspace{0.25em}%
    \begin{minipage}[t]{3mm}%
        \makebox[3mm][c]{\footnotesize \faBook}
    \end{minipage}%
    \hspace{0.5em}%
    \normalsize #4
    \par \vspace{0.25em}
    \begin{minipage}[t]{\pubjournallength}%
        \ifstrequal{#5}{}{}{%
        \footnotesize \makebox[3mm][c]{\faChain} \hspace{0.25em} #5
    \end{minipage}%
    \hfill
    \begin{minipage}[t]{-1em}%
        \makebox[0mm][c]{\footnotesize \hspace{.5em} \faCalendar #3}%}
    \end{minipage}%
    %\par%
    %\vspace{0.25em}%
    %\hspace{0.1em}%
    %\begin{minipage}[t]{\dimexpr \linewidth-3mm-0.25em}%
    %    {\footnotesize \faCalendar} %\par %\vspace{0.25em}}
    %\end{minipage}%
    \par%x
    }
}
% achievement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\achievement}[1]{%
    \begin{minipage}[t]{3mm}%
        \makebox[3mm][c]{\footnotesize \faTrophy}
    \end{minipage}%
    \hspace{0.5em}%
    \begin{minipage}[t]{\dimexpr \textwidth-0.5em-3mm}%
        {\normalsize #1\par}
    \end{minipage}%
    \par
    \vspace{0.5em}
}

% lists
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[inline]{enumitem}
\setlength{\tabcolsep}{0in}
\setlist[itemize]{noitemsep, topsep=0pt, leftmargin=1.5em \small}
%%% Bold Faced Item list
\newcommand{\skilling}[2]{
    \item{
        \textbf{#1}:    {#2}
        }
}

\newenvironment{zitemize}{
    \small % Reduces the font size
    \raggedright % Prevents hyphenation
    \vspace{-.3em}
    \begin{itemize} 
        \itemsep 0.5em % Adjust the space between items here
        \parskip 0pt 
        \parsep 0pt
    }
    {
        \end{itemize}
        \vspace{0.5em} % Adjust the space after the list here
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FINAL FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\pagestyle{headerhighlightmain}
\RequirePackage{hyperref}
\hypersetup{colorlinks=true,urlcolor=link-color}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  THE END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
