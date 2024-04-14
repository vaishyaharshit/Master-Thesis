::@ECHO OFF

SET TEXMFS=C:\Daten\miktex-portable\texmfs
if exist "%TEXMFS%\" (
    goto start
)

SET TEXMFS=C:\Program Files\MiKTeX 2.9\texmfs
if exist "%TEXMFS%\" (
    goto start
)

:: create more of these if exist to cover more installations! and make a merge request...

:start

:: use latexmk if it is installed and perl available
SET latexmk=0

perl -e1 2>NUL
if "%ERRORLEVEL%" == "0" (
    if exist "%TEXMFS%\install\miktex\bin\x64\latexmk.exe" (
        SET latexmk=1
    )
)

SET thesis=0
SET singleRun=0
SET clean=0

if "%1" == "" (
    SET thesis=1
)

if "%1" == "all" (
    SET thesis=1
)

if "%1" == "allF" (
    SET thesis=1
    SET singleRun=1
)

if "%1" == "thesis" (
    SET thesis=1
)

if "%1" == "thesisF" (
    SET thesis=1
    SET singleRun=1
)

if "%1" == "clean" (
    SET clean=1
)

if "%thesis%" == "1" (
    if "%latexmk%" == "1" (
        "%TEXMFS%\install\miktex\bin\x64\latexmk.exe" -bibtex -lualatex -lualatex="lualatex -synctex=1 -interaction=nonstopmode --shell-escape" -g  thesis.tex
    ) else (
        "%TEXMFS%\install\miktex\bin\x64\lualatex.exe" -synctex=1 -interaction=nonstopmode --shell-escape thesis.tex
        if "%singleRun%" == "0" (
            "%TEXMFS%\install\biber\bin\windows-x64\biber.exe"  thesis
            "%TEXMFS%\install\miktex\bin\x64\lualatex.exe" -synctex=1 -interaction=nonstopmode --shell-escape thesis.tex
            if exist thesis.idx (
                "%TEXMFS%\install\miktex\bin\x64\makeindex.exe" thesis.idx
            )
            "%TEXMFS%\install\miktex\bin\x64\lualatex.exe" -synctex=1 -interaction=nonstopmode --shell-escape thesis.tex
        )
    )
)

if "%clean%" == "1" (
    del /q *.nav
    del /q *.snm
    del /q *.acr
    del /q *.aux
    del /q *.auxlock
    del /q *.bbl
    del /q *.bcf
    del /q *.blg
    del /q *.run.xml
    del /q *.bak
    del /q *.lot
    del /q *.out
    del /q *.synctex.gz
    del /q *.synctex(busy)
    del /q *.toc
    del /q *.ind
    del /q *.ilg
    del /q *.idx
    del /q *.xmpdata
    del /q *.xmpi
    del /q *.atfi
    del /q *.log
    del /q *.lof
    del /q *.synctex.gz(busy)
    del /q *.fls
    del /q *.fdb_latexmk
    for %%i in (standalones bibliography) do (
        cd %%i
        del /s /q *.nav
        del /s /q *.snm
        del /s /q *.acr
        del /s /q *.aux
        del /s /q *.auxlock
        del /s /q *.bbl
        del /s /q *.bcf
        del /s /q *.blg
        del /s /q *.run.xml
        del /s /q *.bak
        del /s /q *.lot
        del /s /q *.out
        del /s /q *.synctex.gz
        del /s /q *.synctex(busy)
        del /s /q *.toc
        del /s /q *.ind
        del /s /q *.ilg
        del /s /q *.idx
        del /s /q *.xmpdata
        del /s /q *.xmpi
        del /s /q *.atfi
        del /s /q *.log
        del /s /q *.lof
        del /s /q *.synctex.gz(busy)
        del /s /q *.fls
        del /s /q *.fdb_latexmk
        cd ..
    )
)
 
