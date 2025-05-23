# SCOPUS MODS
## Uppdatering 20250410
Scripten import.py, merge_all_xml.py och transscopus.py ersätts av ScopusMods.py som kör hela processen (laddar ner poster från Scopus, slår samman till en fil som transformeras till DIVA mods och klassas med Nationell ämneskategori. Scriptet använder transform.xslt och all.xml för att genomföra transformeringen.

1) Se till att Scopus API nyckel ligger i .env (SCOPUS_API_KEY='YOUR_API_KEY')
2) Lägg in eid på poster som ska importeras i scriptet ScopusMods
3) Kolla så foldern SCOPUS (i samma folder som scriptet) är tom
4)  Kör scriptet ScopusMods - filen filen scopus_yymmdd.xml skapas och kan importeras (som mods3) i DIVA, Nationell ämneskategori läggs till om man får träff i Swepubs classify API.

Att tänka på:
1) Om affilieringsid matchar Mau i Scopusdatan läggs '$$$' framför affiliering så att Mau forskare ska vara lätta att hitta och koppla i datan.
2) Scopus skiljer inte på antologier och monografier vad gäller bok poster – allt läggs som monografi nu. 
3) Vissa bokkapitel ligger dubbelt i scopus – dels med boken som host, dels med serien. 
4) Scopus-id används INTE för att avgöra dubletter i diva-import, så viktigt kolla vad apan hittar i diva för det som inte har DOI. 
5) Allt går in som engelska (går att lägga till så språk kollas i koden, men är det lönt?) 


## 20250304

Ett antal script som transformerar XML från Scopus API till DiVA mods.

Scripten körs lokalt (än så länge) - gör så här:

1) Lägg in eid på poster som ska importeras i import.py
2) Kolla så mappen SCOPUS (i downloadsfoldern) är tom 
3) Kör scriptet import.py - varje eid blir en post som sparas i mappen SCOPUS under downloads.
4) Kör scriptet merge_all_xml.py - alla filer i mappen SCOPUS slås samman till en fil med namnet merged.xml (sparas i downloads/ScopusMods).
5) Kör scriptet transscopus.py - filen scopus_yymmdd.xml skapas och kan importeras (som mods3) i DIVA, Nationell ämneskategori läggs till om man får träff i Swepubs classify API. 

