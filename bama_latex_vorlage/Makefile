.PHONY: FORCE_MAKE

all: thesis.pdf
thesis: thesis.pdf
	
%.pdf: %.tex FORCE_MAKE
	latexmk -bibtex -lualatex -lualatex="lualatex -synctex=1 --shell-escape" -g  $<
	#-interaction=nonstopmode
	
clean:	
	-rm *.nav
	-rm *.snm
	-rm *.acr
	-rm *.aux
	-rm *.auxlock
	-rm *.bbl
	-rm *.bcf
	-rm *.blg
	-rm *.run.xml
	-rm *.bak
	-rm *.lot
	-rm *.out
	-rm *.synctex.gz
	-rm *.synctex(busy)
	-rm *.toc
	-rm *.ind
	-rm *.ilg
	-rm *.idx
	-rm *.xmpdata
	-rm *.xmpi
	-rm *.atfi
	-rm *.log
	-rm *.lof
	-rm *.synctex.gz(busy)
	-rm *.fls
	-rm *.fdb_latexmk
	for i in standalones bibliography ; do \
		cd $$i ; \
		find . -name "*.nav" -type f -delete ; \
		find . -name "*.snm" -type f -delete ; \
		find . -name "*.acr" -type f -delete ; \
		find . -name "*.aux" -type f -delete ; \
		find . -name "*.auxlock" -type f -delete ; \
		find . -name "*.bbl" -type f -delete ; \
		find . -name "*.bcf" -type f -delete ; \
		find . -name "*.blg" -type f -delete ; \
		find . -name "*.run.xml" -type f -delete ; \
		find . -name "*.bak" -type f -delete ; \
		find . -name "*.lot" -type f -delete ; \
		find . -name "*.out" -type f -delete ; \
		find . -name "*.synctex.gz" -type f -delete ; \
		find . -name "*.synctex(busy)" -type f -delete ; \
		find . -name "*.toc" -type f -delete ; \
		find . -name "*.ind" -type f -delete ; \
		find . -name "*.ilg" -type f -delete ; \
		find . -name "*.idx" -type f -delete ; \
		find . -name "*.xmpdata" -type f -delete ; \
		find . -name "*.xmpi" -type f -delete ; \
		find . -name "*.atfi" -type f -delete ; \
		find . -name "*.log" -type f -delete ; \
		find . -name "*.lof" -type f -delete ; \
		find . -name "*.synctex.gz(busy)" -type f -delete ; \
		find . -name "*.fls" -type f -delete ; \
		find . -name "*.fdb_latexmk" -type f -delete ; \
		cd .. ; \
	done
 
