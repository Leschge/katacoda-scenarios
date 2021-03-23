### Aggregatfunktionen
Die Basics kannst du jetzt und nach diesem Schritt bist du auch für reale Probleme gewappnet.

Du möchtest deinem Kunden nun mitteilen, wieviel alle Artikel zusammen kosten.
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

Die Funktion `jsonb_array_elements()` sorgt dafür, dass jeder Artikel (in unserem Fall ein Objekt) aus dem Array `Artikel` herausgelesen und in eine eigene Zeile eingetragen wird.
