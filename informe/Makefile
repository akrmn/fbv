all: informe

informe: 
	pandoc --template="static/style.latex" -o tmp.pdf -f markdown+table_captions informe.md q11.md q12.md q13.md q21.md q22.md q23.md 
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=informe.pdf static/portada.pdf tmp.pdf
	rm tmp.pdf
