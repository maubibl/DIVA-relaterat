Script som omvandlar Pubmed XML till DiVA mods:
Hämta Pubmed XML genom att gå till https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=[PMID1],[PMID2],[PMID3]&retmode=xml.
Spara sidan som efetch.fcgi.xml (om du använder firefox föreslås detta namn automatiskt). Spara ner i Scopus mods mappen. 

Kör scriptet pmtrans.py, resultatet sparas som pubmed_yymmdd.xml i Scopus mods mappen.  
