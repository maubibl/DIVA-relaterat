# Script som omvandlar Pubmed XML till DiVA mods:
## Uppdatering 2025-12-15
Uppdaterat så script hämtar xml via API. Skriv in pubmed id på posterna som ska omvandlas efter 
pubmed_ids = längst upp i scriptet. Filerna sparas som pubmed_yymmdd.xml i samma mapp som scriptet. 

## 2025-03-12
Tillskillnad från den inbygda Pubmed-importen i DiVA får man med affilieringsinfo, abstract, och Nationell ämneskategori (om man får träff i Swepubs classify API).  

Hämta Pubmed XML genom att gå till https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=[PMID1],[PMID2],[PMID3]&retmode=xml.
Spara sidan som efetch.fcgi.xml (om du använder firefox föreslås detta namn automatiskt). Spara ner i Scopus mods mappen. 

Kör scriptet pmtrans.py, resultatet sparas som pubmed_yymmdd.xml i Scopus mods mappen, importera som MODS i DIVA.
