
all: output/static.html

output/static.html: certproc.xsl certificate.en.xml
	xsltproc certproc.xsl certificate.en.xml > output/static.html
