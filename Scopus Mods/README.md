Ett antal script som transformerar XML från Scopus API till DiVA mods.

Scripten körs lokalt (än så länge) - gör så här:

1) Lägg in eid på poster som ska importeras i import.py
2) Kolla så mappen SCOPUS (i downloadsfoldern) är tom 
3) Kör scriptet import.py - varje eid blir en post som sparas i mappen SCOPUS under downloads.
4) Kör scriptet merge_all_xml.py - alla filer i mappen SCOPUS slås samman till en fil med namnet merged.xml (sparas i downloads/ScopusMods).
5) Kör scriptet transscopus.py - filen scopus_yymmdd.xml skapas och kan importeras (som mods3) i DIVA. 

Att tänka på:
Om affilieringsid matchar Mau i Scopusdatan läggs '$$$' framför affiliering så att Mau forskare ska vara lätta att hitta och koppla i datan.
Scopus skiljer inte på antologier och monografier vad gäller bok poster – allt läggs som monografi nu. 
Vissa bokkapitel ligger dubbelt i scopus – dels med boken som host, dels med serien. 
Scopus-id används INTE för att avgöra dubletter i diva-import, så viktigt kolla vad apan hittar i diva för det som inte har DOI. 
Allt går in som engelska (går att lägga till så språk kollas i koden, men är det lönt?) 
