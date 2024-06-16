%This documents contains parts of the FAU-University-Press-LaTeX-Formatvorlage
%https://github.com/UBEN-Webteam/FAU-University-Press-LaTeX-Formatvorlage/blob/main/faupress.cls
%published under LaTeX Project Public License obtainable via http://www.latex-project.org/lppl.txt

%and
%https://gitlab.cs.fau.de/i4/tex/i4thesis

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bama}[LaTeX class for thesis at LTE]

%%% Check for LuaTeX
%%% ----------------

\RequirePackage{ifluatex}
\ifluatex
\else
\ClassError{bama}{You are not using LuaLaTeX for compilation! It is
	highly recommended to use LuaLaTeX, because this template uses lua code.}
\fi

%%% Package options
%%% ---------------

\RequirePackage{ifthen}

\newcommand{\ifgerman}[1]{}
\newcommand{\ifenglish}[1]{#1}

\DeclareOption{german}{
	\renewcommand{\ifgerman}[1]{#1}
	\renewcommand{\ifenglish}[1]{}
}

\DeclareOption{english}{
	\renewcommand{\ifgerman}[1]{}
	\renewcommand{\ifenglish}[1]{#1}
}

\newcommand{\@bama@draft}[1]{#1}
\newcommand{\@bama@final}[1]{}

\DeclareOption{final}{
	\renewcommand{\@bama@draft}[1]{}
	\renewcommand{\@bama@final}[1]{#1}
}

\newcommand{\@bama@standalone}[1]{}
\newcommand{\@bama@nstandalone}[1]{#1}

\DeclareOption{standalone}{%
	\renewcommand{\@bama@standalone}[1]{#1}
	\renewcommand{\@bama@nstandalone}[1]{}
}

\ProcessOptions\relax

\@bama@nstandalone{
	\LoadClass[
	paper=a4,
	twoside,
	fontsize=12pt,
	numbers=noenddot,
	openright,				% Kapitel beginnt    
	rechter Seite
	titlepage,				% Titelblatt auf eigener 
	Seite
	bibliography=totoc,		% Literaturverzeichnis
	listof=totoc			% Listen ins 
	Inhaltsverzeichnis
	]{scrbook}
}

\@bama@standalone{
	\LoadClass[multi=tikzpicture
	]{standalone}
}

\RequirePackage{scrhack}

%%% date and time
%%% -------------

\newcommand{\@bama@today}{
	\num[minimum-integer-digits=2]{\number\day}.%
	\num[minimum-integer-digits=2]{\number\month}.%
	\num[minimum-integer-digits=4]{\number\year}%
}

%%% header and footer
%%% -----------------

\@bama@nstandalone{
	\RequirePackage[automark, headsepline]{scrlayer-scrpage}
	\pagestyle{scrheadings}
	\clearscrheadings
	\ohead{\headmark}
	\ihead{\@thesis}
	
	\@bama@draft{
		\cfoot*{
			\ifgerman{\color{red}Entwurf - Stand: \today}
			\ifenglish{\color{red}Draft - Date: \today}
		}
	}
	
	\@bama@final{
		\cfoot*{ }
	}
	
	\ofoot*{\pagemark}
	
	\pagestyle{scrheadings}
	\automark[chapter]{chapter}
	\automark*[section]{}
}

%%% Header
%%% ------

\RequirePackage{shellesc}       %Nötig für --shell-escape bei lualatex

%%% font and text
%%% -------------

\RequirePackage{xstring, xspace} % Silbentrennung bei Sonderzeichen

\RequirePackage{fontspec} % Essenzielle Schriftverwaltung unter lualatex

%normal font
\IfFontExistsTF{TeX Gyre Termes}{
    \setmainfont{TeX Gyre Termes}}{
    \setmainfont[
    UprightFont = *-regular ,
    BoldFont = *-bold ,
    ItalicFont = *-italic ,
    Extension = .otf
    ]{TeX Gyre Termes}
}

%headings font
\IfFontExistsTF{TeX Gyre Heros}{
    \setsansfont{TeX Gyre Heros}}{
    \setsansfont[
    UprightFont = *-regular ,
    BoldFont = *-bold ,
    ItalicFont = *-italic ,
    Extension = .otf
    ]{TeX Gyre Heros}
}

%listings font
\IfFontExistsTF{Latin Modern Mono}{
    \setmonofont{Latin Modern Mono}[Scale=MatchUppercase]}{
    \setmonofont{lmmono10-regular.otf}[Scale=MatchUppercase]}

%%% tables
%%% ------

\RequirePackage{array, longtable} %longtables can span multiple pages
\renewcommand{\arraystretch}{1.25} %bigger distance between rows
\RequirePackage{booktabs} %cleaner table look

%%% acronyms
%%% --------

\RequirePackage{acro}
%\acsetup{list-style=longtable, only-used=false, sort=false} %option for outdated acro package
\acsetup{list/template=longtable, list/display=used, list/sort=false}

\let\printacronymsorig\printacronyms
\renewcommand{\printacronyms}{
	\cleardoublepage
	{\setlength{\LTleft}{0pt}
		\printacronymsorig[heading=chapter, name=\abbrvttl]}
}

%%% table of contents
%%% -----------------

\@bama@nstandalone{
	\let\tableofcontentsorig\tableofcontents
	\renewcommand{\tableofcontents}{
		\cleardoublepage
		\iftocfeature{toc}{totoc}{}{%
			\ifgerman{\pdfbookmark{\contentsname}{Inhaltsverzeichnis}}%
			\ifenglish{\pdfbookmark{\contentsname}{Contents}}%
		}
		\tableofcontentsorig
	}
	
	\setcounter{tocdepth}{3} %Gibt an, bis in welche Tiefe das Inhaltsverzeichnis geht
	\setcounter{secnumdepth}{3}
}

%%% text
%%% ----

\RequirePackage[top=30mm, left=26mm, right=26mm, bottom=35mm, headsep=10mm, footskip=12mm]{geometry} %page dimensions

\defaultfontfeatures{Ligatures=TeX}
\RequirePackage[autostyle]{csquotes}
\RequirePackage{polyglossia}%Ersatz für babel
\ifgerman{
	\setdefaultlanguage{german}
	\setotherlanguage{english}}
\ifenglish{
	\setdefaultlanguage{english}
	\setotherlanguage{german}}
%\RequirePackage[english, ngerman]{babel}
\RequirePackage{hyphenat} %less line breaks
\RequirePackage{microtype}
\global\hyphenpenalty=9000
\global\pretolerance=7000
\global\tolerance=7500
%\setlanghypenmins{ngerman}{65}

\clubpenalty = 10000  % schliesst Schusterjungen (Anfangszeile eines Absatzes am Kolumnen- oder Spaltenende) aus
\widowpenalty = 10000 % schliesst Hurenkinder (letzte Zeile vom mehrzeiligen Absatz am Seiten- oder Spaltenbeginn) aus

%set headings according to language
\ifgerman{
	\setdefaultlanguage[spelling=new]{german}
	\newcommand{\abbrvttl}{Abkürzungsverzeichnis}
	\newcommand{\bibttl}{Literaturverzeichnis}
}%
\ifenglish{
	\setdefaultlanguage{english}
	\setotherlanguage[babelshorthands=true, spelling=new]{german}
	\newcommand{\abbrvttl}{List of Abbreviations}
	\newcommand{\bibttl}{Bibliography}
}

\addto\captionsngerman{
	\renewcommand{\figurename}{Abb.}
	\renewcommand{\tablename}{Tab.}
}

%%% literature (with biber - not bibtex)
%%% ----------

\@bama@nstandalone{
	\RequirePackage[
		backend=biber,
		style=bibliography/ltebibstyle,%LTE style according to biblatex_LTE.bbx
		isbn=false,
		doi=false,
		eprint=false,
		url=false,
		defernumbers=true]{biblatex}
	
	\@bama@draft{
		\ExecuteBibliographyOptions{backref=false}
	}
	
	\@bama@final{
		\ExecuteBibliographyOptions{backref=true}
	}
	
	%\ExecuteBibliographyOptions{sorting=ydmdnt} %sort reference by date
	\ExecuteBibliographyOptions{giveninits=true} 	%Vor- und Mittelnamen als Initialen ausgeben
	\ExecuteBibliographyOptions{maxbibnames=6} 		%max angezeigte namen, dann auf minnames reduziert und u.a. ergänzt
	\ExecuteBibliographyOptions{minbibnames=4} 		%siehe maxnames
	\ExecuteBibliographyOptions{maxcitenames=3} 	%analog für citeauthor, o.ä.
	\ExecuteBibliographyOptions{mincitenames=1} 	%siehe maxnames
	
	% Einstellungen für den Zeilenumbruch von URLs
	\def\UrlBreaks{\do\=\do\.\do\?\do\&\do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z\do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9\do\0}
	\Urlmuskip = 0mu plus 1mu
	
	\let\printbibliographyorig\printbibliography
	\renewcommand{\printbibliography}{
		\printbibliographyorig[title=\bibttl, heading=bibintoc]
	}
}

\@bama@standalone{
	\RequirePackage[
		backend=biber]{biblatex}
}

%%% titlepage
%%% ---------

\@bama@nstandalone{
	\newcommand*\@firstname{\@latex@error{Bama: No \noexpand\firstname given}}
	\newcommand*\firstname[1]{\renewcommand\@firstname{#1}}
	
	\newcommand*\@lastname{\@latex@error{Bama: No \noexpand\lastname given}}
	\newcommand*\lastname[1]{\renewcommand\@lastname{#1}}
	
	\newcommand*\@thesis{\@latex@error{Bama: No \noexpand\thesis given}}
	\newcommand*\thesis[1]{\renewcommand\@thesis{#1}}
	
	\newcommand*\@course{\@latex@error{Bama: No \noexpand\course given}}
	\newcommand*\course[1]{\renewcommand\@course{#1}}
	
	\renewcommand*\@title{\@latex@error{Bama: No \noexpand\title given}}
	\renewcommand*\title[1]{\renewcommand\@title{#1}}
	
	\renewcommand*\@subtitle{\@latex@error{Bama: No \noexpand\subtitle given}}
	\renewcommand*\subtitle[1]{\renewcommand\@subtitle{#1}}
	
	\newcommand*\@keywords{\@latex@error{Bama: No \noexpand\keywords given}}
	\newcommand*\keywords[1]{\renewcommand\@keywords{#1}}
	
	\newcommand*\@supervisor{\@latex@error{Bama: No \noexpand\supervisor given}}
	\newcommand*\supervisor[1]{\renewcommand\@supervisor{#1}}
	
	\newcommand*\@thesisbegin{\@latex@error{Bama: No \noexpand\thesisbegin given}}
	\newcommand*\thesisbegin[1]{\renewcommand\@thesisbegin{#1}}
	
	\newcommand*\@thesisend{\@latex@error{Bama: No \noexpand\thesisend given}}
	\newcommand*\thesisend[1]{\renewcommand\@thesisend{#1}}
	
	\newcommand*\@thesisendmonth{\@latex@error{Bama: No \noexpand\thesisendmonth given}}
	\newcommand*\thesisendmonth[1]{\renewcommand\@thesisendmonth{#1}}
	
	\newcommand*\@thesisendyear{\@latex@error{Bama: No \noexpand\thesisendyear given}}
	\newcommand*\thesisendyear[1]{\renewcommand\@thesisendyear{#1}}
	
	\newcommand*\@abstract{\@latex@error{Bama: No \noexpand\abstract given}}
	\newcommand*\abstract[1]{\renewcommand\@abstract{#1}}
}

\@bama@nstandalone{
	\newcommand{\declaration}{
		\ifgerman{\chapter*{Erklärung}}
		\ifenglish{\chapter*{Declaration}}
		\label{sec:Erklärung}
		
		\ifgerman{
			Ich versichere, dass ich die Arbeit ohne fremde Hilfe und ohne Benutzung anderer als der angegebenen Quellen angefertigt habe und dass die Arbeit in gleicher oder ähnlicher Form noch keiner anderen Prüfungsbehörde vorgelegen hat und von dieser als Teil einer Prüfungsleistung angenommen wurde.\\
			Alle Ausführungen, die wörtlich oder sinngemäß übernommen wurden, sind als solche gekennzeichnet.\\
		}
		
		\ifenglish{
			I declare that the work is entirely my own and was produced with no assistance from third parties.\\
			I certify that the work has not been submitted in the same or any similar form for assessment to any other examining body and all references, direct and indirect, are indicated as such and have been cited accordingly.\\
		}
		
		\vspace{1.0cm}
		\ifgerman{\noindent Erlangen, den \today}
		\ifenglish{\noindent Erlangen, \today}
		\vspace{2.5cm}
		\\
		\@author
	}
}

\usepackage{graphicx}
\usepackage{float}

\@bama@nstandalone{
	\renewcommand{\maketitle}{
		\begin{titlepage}
			\includegraphics[height=3cm]{graphics/logo/FAU_TechFak}
			\hfill
			\ifgerman{\includegraphics[height=3cm]{graphics/logo/LTE_Logo_Q}}
			\ifenglish{\includegraphics[height=3cm]{graphics/logo/LTE_Logo_Q_English}}
			\vspace{0.5cm}
			
			\begin{center}
			\LARGE
			\textbf{\ifgerman{Lehrstuhl für Technische Elektronik}\ifenglish{Institute for Electronics Engineering}} \\
			Prof.~Dr.-Ing.~Dr.-Ing.~habil.~Robert~Weigel	\\
			Prof.~Dr.-Ing.~Georg~Fischer\\
			\vspace{0.7cm}
	
			\LARGE
			\@bama@draft{{\color{red}Draft: }}\textbf{\@thesis}
			\vspace{0.7cm}
	
			\large
			\ifenglish{in the degree course}\ifgerman{im Studiengang}\\ \enquote{\@course}\\
			\vspace{0.5cm}
			\ifgerman{von}\ifenglish{by}
			\vspace{0.5cm}
	
			\LARGE{
				\@firstname \@lastname}
			\vspace{0.7cm}
	
			\large
			\ifgerman{zum Thema}\ifenglish{on the topic of}
			\vspace{0.7cm}
	
			\LARGE
			\textbf{\@title}
			\vspace{0.7cm}
	
			\large
			\vfill
			\begin{tabular}{p{0.2\textwidth}p{0.7\textwidth}}
				\ifgerman{Betreuer}\ifenglish{Tutor}: &
				{\StrSubstitute[0]{\@supervisor}{;}{\newline}} \\
				&\\
				\ifgerman{Beginn}\ifenglish{Start date}: & {\@thesisbegin} \\
				\ifgerman{Abgabe}\ifenglish{End date}: & {\@thesisend}
			\end{tabular}
			\end{center}
		\end{titlepage}%
	}
}

%%% metadata
%%% --------

%	%PDF metadata is prepared for inclusion in the output pdf
%	%this data is used for archiving information about thesis at LTE
%	%it can be imported to jabref by drag and drop
%	%https://tex.stackexchange.com/questions/257855/lualatex-write-latex-commands-to-file
\RequirePackage{fancyvrb}
\RequirePackage{luacode}

%must not be indented
\begin{luacode}
	function OpenFile(mode,name) out=io.open(name,mode) return end
	function CloseFile() io.close(out) return end
\end{luacode} 

\newcommand\OpenFile[2][a]{\luaexec{OpenFile('#1','#2')}}
\newcommand{\CloseFile}{\luaexec{CloseFile()}}
	
\newcommand{\WriteLn}[1]{\luaexec{out:write('\string#1'.."\string\n")}}
\newcommand{\WriteLnSep}[1]{\luaexec{out:write(string.gsub('\string#1',';','\\sep').."\string\n")}}
\newcommand{\WriteLnSepNoTitle}[1]{\luaexec{out:write(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub('\string#1','habil.',''),'M.Sc.',''),'Dr.-Ing.',''),'Prof.',''),';','\\sep').."\string\n")}}
%\newcommand{\Write}[1]{\luaexec{out:write(string.gsub('\string#1',';','\\sep'))}}

\@bama@nstandalone{
	\AtEndDocument{
		\OpenFile[w]{thesis.xmpdata}
		\WriteLn{\\Title{\@title}}
		\WriteLnSepNoTitle{\\Author{\@firstname \@lastname \\sep \@supervisor}}
		\ifgerman{\WriteLn{\\Language{de-DE}}}
		\ifenglish{\WriteLn{\\Language{en-GB}}}
		\WriteLn{\\Subject{\@abstract}}
		\WriteLnSep{\\Keywords{\@keywords}}
		\WriteLn{\\Date{\@thesisendyear}}
		\WriteLn{\\Relation{bibtex/citationkey/\@lastname \@thesisendyear}}
		\WriteLn{\\Relation{bibtex/booktitle/\@thesis}}
		\WriteLn{\\Relation{bibtex/owner/LTE}}
		\WriteLn{\\Relation{bibtex/timestamp/\number\year-\number\month-\number\day}}
		\WriteLn{\\Relation{bibtex/url/https://lfte.de}}
		\ifthenelse{\equal{\@thesisendmonth}{1}}{\WriteLn{\\Relation{bibtex/month/January}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{2}}{\WriteLn{\\Relation{bibtex/month/February}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{3}}{\WriteLn{\\Relation{bibtex/month/March}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{4}}{\WriteLn{\\Relation{bibtex/month/April}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{5}}{\WriteLn{\\Relation{bibtex/month/May}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{6}}{\WriteLn{\\Relation{bibtex/month/June}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{7}}{\WriteLn{\\Relation{bibtex/month/July}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{8}}{\WriteLn{\\Relation{bibtex/month/August}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{9}}{\WriteLn{\\Relation{bibtex/month/September}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{10}}{\WriteLn{\\Relation{bibtex/month/October}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{11}}{\WriteLn{\\Relation{bibtex/month/November}}}{}
		\ifthenelse{\equal{\@thesisendmonth}{12}}{\WriteLn{\\Relation{bibtex/month/December}}}{}
		\CloseFile
	}
}

%% PDF output
%% ----------

\@bama@nstandalone{
	%PDF export confirming to PDF/A-2b
	%conformance with the standard can be checked with Adobe Acrobat Pro -> PDF Standards -> Preflight
	%https://tex.stackexchange.com/questions/374991/lualatex-and-pdfminorversion
	\RequirePackage{luatex85}
	\RequirePackage[a-2b,mathxmp]{pdfx}
	
	%hyperref is loaded by pdfx
	\hypersetup{unicode=true, hidelinks, breaklinks=true, pdfencoding=unicode}
}
