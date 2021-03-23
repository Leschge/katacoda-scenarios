### Aggregatfunktionen
Die Basics kannst du jetzt und nach diesem Schritt bist du auch für reale Probleme gewappnet.

Du möchtest deinen Kunden nun mitteilen, wieviel die Artikel zusammen kosten.
Dafür brauchen wir die Aggregatfunktion `SUM`. Und weil es gar nicht so einfach ist über verschachtelte Arrays zu iterieren, fangen wir ganz langsam an.

Zuerst müssen wir die einzelnen Artikel in eine eigene Tabelle bringen und können erst dann auf die neue Tabelle unsere Aggregatfunktion anwenden.
Für den ersten Schritt benutzen wir das `WITH`-Statement, welches so aufgebaut ist:
```
WITH temporäreTabelle1 (spaltenName1, ...) AS
     (SELECT ...)
     
SELECT ...
```
Mit dem ersten `SELECT` suchen wir unsere Artikel, mit dem zweiten `SELECT` können wir auf die neue Tabelle unsere Aggregatfunktion anwenden.

`WITH AlleArtikel AS ( SELECT jsonb_array_elements(details->'Artikel') FROM rechnungen)
SELECT * FROM AlleArtikel;`{{execute}}

Die Funktion `jsonb_array_elements()` sorgt dafür, dass jeder Artikel (in unserem Fall ein Objekt) aus dem Array `Artikel` herausgelesen und in eine eigene Zeile in der neuen Tabelle `AlleArtikel` eingetragen wird.  
Vielleicht erkennst du, dass wir nur eine Spalte mit dem Namen `jsonb_array_elements` haben. Das ist ziemlich unschön, weshalb wir ein weiteres `AS` einbauen damit unsere Spalte `Artikel` heisst.

`WITH AlleArtikel AS ( SELECT jsonb_array_elements(details->'Artikel') AS Artikel FROM rechnungen)
SELECT * FROM AlleArtikel;`{{execute}}

Jetzt können wir endlich die Aggregatfunktion auf die neue Tabelle `AlleArtikel` anwenden.

WITH AlleArtikel AS ( SELECT jsonb_array_elements(details->'Artikel') AS Artikel FROM rechnungen)
SELECT SUM( CAST ( Artikel ->> 'Preis' AS FLOAT )) FROM AlleArtikel;

Bevor wir `SUM` verwenden können, müssen wir unsere Preise allerdings in Kommazahlen (`FLOAT`) konvertieren.
