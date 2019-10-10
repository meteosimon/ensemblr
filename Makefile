README.md: README.Rmd
	Rscript -e "rmarkdown::render('$<', output_format = 'md_document')"

