all: informe

informe: 
	pandoc --template="style.latex" informe.md -o tmp.pdf -f markdown+table_captions
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=informe.pdf portada.pdf tmp.pdf
	del tmp.pdf
