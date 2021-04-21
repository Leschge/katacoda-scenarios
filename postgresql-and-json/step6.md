
Wie du aus Schritt 2 weißt, benutzen wir den _jsonb_ Datentyp. Dadurch ist es uns möglich Indexierung innerhalb unserer JSON-Einträge vorzunehmen.

PostgreSQL bietet verschiedene Arten oder gar Infrastrukturen von Indizes für jeweils verschiedene Aufgabenfelder an.
Dazu gehören B-Trees, Hashes, GINs und noch ein Paar mehr. Alle hier zu erklären würde leider den Rahmen sprengen. Deshalb beschränken wir uns auf die für _jsonb_ gängisten Arten.  
Übrigens, wird beim `CREATE INDEX` kein Indextyp angegeben, wird standardmäßig ein B-Tree erstellt.

### B-Tree
der B-Tree ist geeignet für Gleicheits- und Bereichsabfragen. Verwendete Operanten sind hierfür `<` `<=` `=` `>=` oder `>`. Zusätzlich ist dieser Index für Teilstringabfragen zu Beginn eines Strings sinnvoll, dafür wird der `LIKE` Operator benutzt.
Willst du also beispielsweise häufig alle Rechnungen, bei denen der Kundenname mit "Mich" anfängt ausgeben, so ist ein B-Tree Index geeignet. Die passende Abfrage dazu lautet so:

`SELECT * FROM rechnungen WHERE details ->> 'Name' LIKE 'Mich%';`{{execute}}

Als Ergebnis bekommst du demnach "**Mich**elle Seeger" und "**Mich**ael Müller".

Natürlich benötigt jede Abfrage im System eine gewisse Berechnungszeit und auch sogenannte Berechnungskosten.  
Die Berechnungskosten für eine Abfrage kannst du mit einem `EXPLAIN` vor der eigentlichen Abfrage ausgeben:  

`EXPLAIN SELECT * FROM rechnungen WHERE details ->> 'Name' LIKE 'Mich%';`{{execute}}

Vermutlich findest du einen Wert von `29.05`.   
Jetzt erstellen wir einen Index für die Kundennamen:  

`CREATE INDEX ind_namen ON rechnungen USING BTREE ((details->'Name'));`{{execute}}

Und lassen uns erneut die Kosten ausgeben:  

`EXPLAIN SELECT * FROM rechnungen WHERE details ->> 'Name' LIKE 'Mich%';`{{execute}}

Nun solltest du einen deutlich geringeren Wert statt die `29.05` sehen. Wir tun damit unserer Anwendung und der Datenbank also einen Gefallen.  
Einen zeitlichen Unterschied solltest du bei unseren 4 Einträgen jedoch nicht festellen.  
**Denn ein Index lohnt sich oft erst ab mehreren tausend Einträgen** und ab dann ist auch die Berechnungszeit deutlich geringer.

### Hash 
Der Hash Index ist  lediglich für rudimentäre Gleichheitsabfragen geeignet. D.h. wenn der verwendete Operant in der Abfrage `=` ist. 


### GIN
Der GIN ist genau genommen eine Infrastruktur von Indizes und bietet [mehrere Arten](https://www.postgresql.org/docs/11/gin-examples.html) an. Standardmäßig erstellt der GIN Index aber ebenfalls einen B-Tree, weshalb wir hier nicht weiter ausschweifen.  
Er ist für zusammengesetzte Daten und für Abfragen, die nach Werten innerhalb diesen zusammengesetzten Daten suchen, geeignet. Also für Abfragen mit dem schon zuvor benutzten `@>` Operant. Zusätzlich ist der GIN Index dazu geeignet um zu prüfen, ob ein Schlüssel oder Wert existiert. Dafür werden die Operanten `?` `?&` `?|` verwendet.


Wie du siehst, solltest du also je nach Art deiner Abfragen auf verschiedene Index Arten setzen, um ein Ergebnis schnell zurück zu bekommen.

Und das wars auch schon, auf der nächsten Seite findest du noch ein paar Good-To-Knows 👨‍💻
