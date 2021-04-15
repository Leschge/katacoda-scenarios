
Wie du aus Schritt 2 weißt, benutzen wir den _jsonb_ Datentyp. Dadurch ist es uns möglich Indexierung innerhalb unserer JSON-Einträge vorzunehmen.

PostgreSQL bietet verschiedene Arten oder gar Infrastrukturen von Indizes für jeweils verschiedene Aufgabenfelder an.
Dazu gehören B-Trees, Hashes, GINs und noch ein Paar mehr. Alle hier zu erklären würde leider den Rahmen sprengen. Deshalb beschränken wir uns auf die für _jsonb_ gängisten Arten.  
Übrigens, wird beim `CREATE INDEX` kein Indextyp angegeben, wird standardmäßig ein B-Tree erstellt.

### B-Tree
Ist geeignet für Gleicheits- und Bereichsabfragen. Verwendete Operanten sind hierfür `<` `<=` `=` `>=` oder `>`. Zusätzlich ist dieser Index für Teilstringabfragen zu Beginn eines Strings sinnvoll. Z.B. `SELECT * FROM artikel WHERE details -> Name LIKE 'Kurz%' ;` wobei alle Strings wie _Kurzarmhemd_, _Kurze Hosen_, ... zurückgegeben werden.


### Hash 
Ist lediglich für rudimentäre Gleichheitsabfragen geeignet. Verwendeter Operant ist dabei das `=`. 


### GIN
Der GIN (Generalized Inverted Indexes) ist genau genommen eine Infrastruktur von Indizes und bietet [multiple Arten](https://www.postgresql.org/docs/11/gin-examples.html) an. Standardmäßig erstellt der GIN Index aber ebenfalls einen B-Tree, weshalb wir hier nicht weiter ausschweifen.  
Er ist für zusammengesetzte Daten ( aus Schlüssel und Wert ) und für Abfragen, die nach Werten innerhalb diesen zusammengesetzten Daten suchen, geeignet. Um zu prüfen, ob ein Schlüssel oder Wert existiert werden die Operanten `?` `?&` `?|` verwendet. Den Operant `@>` kennst du ja aus vorherigem Schritt. 




`SELECT details ->> 'Name', details ->> 'Datum' FROM rechnungen WHERE to_date(details ->> 'Datum', 'DD-MM-YYYY') > to_date('22-03-2021', 'DD-MM-YYYY');
`{{execute}}

Die `to_date()` Funktion konvertiert den String in einen `timestamp` mit dem Format (DD-MM-YYYY) um den Vergleich ausführen zu können.

### "Enthält" Bedingung

Manchmal ist es ganz praktisch, wenn du gleich ein ganzes Objekt oder Array in einer Abfrage vergleichen kannst. 
Nehmen wir als Beispiel die Adresse zur Hand. Du möchtest einen Kunden anhand dieser bestimmen, aber nicht 
jedes Feld ( "Strasse", "PLZ und "Ort" ) einzeln überprüfen. Hier bietet JSONB den `@>` oder `<@` Operator an, dieser gibt `true` zurück, wenn mindestens der Vergleichswert im Objekt oder Array gefunden wurde.   
Für unsere Adresse sieht die Abfrage so aus:

`SELECT details ->> 'Name', details ->> 'Adresse' FROM rechnungen WHERE details -> 'Adresse' @> '{ "Strasse": "Winkelgasse 9", "PLZ": "83711", "Ort": "Konstanz" }';
`{{execute}}

Oder wenn du alle Kunden auslesen willst, die Socken für genau 7.95 gekauft haben:

`SELECT details ->> 'Name' FROM rechnungen WHERE details -> 'Artikel' @> '[{ "Name": "Socken", "Preis": "7.95" }]';
`{{execute}}
