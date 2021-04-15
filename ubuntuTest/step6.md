
Wie du aus Schritt 2 weißt, benutzen wir den _jsonb_ Datentyp. Dadurch ist es uns möglich Indexierung innerhalb unserer JSON-Einträge vorzunehmen.

PostgreSQL bietet verschiedene Arten oder gar Infrastrukturen von Indizes für jeweils verschiedene Aufgabenfelder an.
Dazu gehören B-Trees, Hashes, GINs und noch ein Paar mehr. Alle hier zu erklären würde leider den Rahmen sprengen. Deshalb beschränken wir uns auf die für _jsonb_ gängisten Arten.  
Übrigens, wird beim `CREATE INDEX` kein Indextyp angegeben, wird standardmäßig ein B-Tree erstellt.

### B-Tree
Ist geeignet für Gleicheits- und Bereichsabfragen. Verwendete Operanten sind hierfür `<` `<=` `=` `>=` oder `>`. Zusätzlich ist dieser Index für Teilstringabfragen zu Beginn eines Strings sinnvoll.  
Willst du beispielsweise häufig alle Rechnungen, bei denen der Name mit "Mich" anfängt, so ist ein B-Tree geeignet. Die passende Abfrage lautet so:
`SELECT * FROM rechnungen WHERE details -> 'Name' LIKE 'Mich%';`{{execute}}


### Hash 
Ist lediglich für rudimentäre Gleichheitsabfragen geeignet. Verwendeter Operant ist dabei das `=`. 


### GIN
Der GIN ist genau genommen eine Infrastruktur von Indizes und bietet [mehrere Arten](https://www.postgresql.org/docs/11/gin-examples.html) an. Standardmäßig erstellt der GIN Index aber ebenfalls einen B-Tree, weshalb wir hier nicht weiter ausschweifen.  
Er ist für zusammengesetzte Daten und für Abfragen, die nach Werten innerhalb diesen zusammengesetzten Daten suchen, geeignet. Um zu prüfen, ob ein Schlüssel oder Wert existiert werden die Operanten `?` `?&` `?|` verwendet. Den Operant `@>` kennst du ja aus vorherigem Schritt. 


