Die Basics kannst du jetzt und nach diesem Schritt bist du auch für reale Probleme gewappnet.

Du möchtest deinen Kunden nun mitteilen, wieviel die Artikel zusammen gekosten haben.
Dafür brauchen wir die Aggregatfunktion `SUM`. Und weil es gar nicht so einfach ist über verschachtelte Arrays zu iterieren, fangen wir ganz langsam an.

__1. Das WITH - Statement__

Zuerst müssen wir die einzelnen Artikel in eine eigene Tabelle bringen und können erst dann auf die neue Tabelle unsere Aggregatfunktion anwenden.
Für den ersten Schritt benutzen wir das `WITH`-Statement. Das entspricht diesem Aufbau:
```
WITH temporäreTabelle1 (spaltenName1, ...) AS
     (SELECT ...)
     
SELECT ...
```
Mit dem ersten `SELECT` suchen wir unsere Artikel und speichern diese in `temporäreTabelle1`. Mit dem zweiten `SELECT` können wir auf diese Tabelle dann unsere Aggregatfunktion anwenden.

`WITH AlleArtikel AS ( SELECT jsonb_array_elements(details->'Artikel') FROM rechnungen)
SELECT * FROM AlleArtikel;`{{execute}}

Die Funktion `jsonb_array_elements()` sorgt dafür, dass jeder Artikel (in unserem Fall ein Objekt) aus dem Array `Artikel` herausgelesen wird und eine eigene Zeile in der neuen Tabelle `AlleArtikel` bekommt.  

__2. Spaltenname hinzufügen__

Vielleicht erkennst du, dass wir in der neuen Tabelle nur eine Spalte mit dem Namen `jsonb_array_elements` haben. Das ist ziemlich unschön, weshalb wir ein weiteres `AS` einbauen damit die Spalte absofort `Artikel` heisst.

`WITH AlleArtikel AS ( SELECT jsonb_array_elements(details->'Artikel') AS Artikel FROM rechnungen)
SELECT * FROM AlleArtikel;`{{execute}}

__3. Die Aggregation__

Jetzt können wir endlich die Aggregatfunktion auf die neue Tabelle `AlleArtikel` anwenden.

`WITH AlleArtikel AS ( SELECT jsonb_array_elements(details->'Artikel') AS Artikel FROM rechnungen)
SELECT SUM( CAST ( Artikel ->> 'Preis' AS FLOAT )) FROM AlleArtikel;`{{execute}}

Bevor wir `SUM` verwenden können, müssen wir unsere Preise allerdings mit `CAST` und `FLOAT` in Kommazahlen konvertieren.

__Cool was?__
Der nächste Schritt befasst sich mit bedingten Abfragen 👨‍🏫
viel Spaß
