all: informe

informe:
	pandoc --smart --filter pandoc-tablenos --filter pandoc-fignos --template="static/style.latex" -o tmp.pdf -f markdown+table_captions introduccion.md estadisticas.md optimizacion.md q11.md q12.md q13.md q21.md q22.md q23.md conclusiones.md anexos.md
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=informe.pdf static/portada.pdf tmp.pdf
	rm tmp.pdf
