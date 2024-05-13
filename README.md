# nf-core/pangenome 
Cluster efficient pangenome graph construction with nf-core/pangenome

The sequences from which the pangenomes were built are stored at https://zenodo.org/doi/10.5281/zenodo.11143858.

## Oxford Bioinformatics Application Notes paper author instructions
https://academic.oup.com/bioinformatics/pages/instructions_for_authors

Application Notes: up to 4 pages; this is approx. 2,600 words or 2,000 words plus one figure.

```shell
# Count the number of words
pdftotext main.pdf - | egrep -e '\w\w\w+' | iconv -f ISO-8859-15 -t UTF-8 | wc -w 
```
