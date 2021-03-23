### JSON Abfragen erzeugen
Um JSON-Abfragen erzeugen zu können, muss dir bewusst sein, dass PostgreSQL zwei verschiedene Operanten für Abfragen zur Verfügung stellt.


Der `->>` Operator  gibt den Rückgabewert als Text zurück.  
Diesen benutzt du in der Regel für Ergebnisse, die direkt von deiner Anwendung konsumiert werden.
```
'{"a": "value"}'::json->>'a'  = value
```


Der `->` Operator hingegen gibt den Rückgabewert als JSON(B)-Objekt aus.  
Dadurch kann der Rückgabewert direkt mit weiteren Befehle verknüpft werden. Oder anders formuliert: Der `->` Operator ermöglicht eine Verkettung von Befehlen.
```
'{"a": "value"}'::json->'a'  = "value"
```

Den Namen kannst du also mit folgender Abfrage ausgeben:

`SELECT details ->> 'Name' FROM rechnungen;`{{execute}}

Den Namen und die Kundennummer kannst du mit folgender Abfrage ausgeben:

`SELECT details ->> 'Name', details ->> 'KundenNr' FROM rechnungen;;`{{execute}}

### Verkettete Abfragen
Die Rechnung beinhaltet zwei Verschachtelungen, die Adresse als Objekt und alle Artikel in einem Array, ebenfalls als Objekt.

__Objekte__

Damit du zum Beispiel den eingetragenen Ort auslesen kannst, benötigst du eine verkettete Abfrage:

`SELECT details ->> 'Adresse' ->> 'Ort' FROM rechnungen;`{{execute}}

Vermutlich bekommst du den Fehler `ERROR: operator does not exist: text ->> ...`, kannst du dir vorstellen weshalb?  
Für eine verschachtelte Abfrage müssen wir mit dem oben genannten JSON(B) Operator arbeiten:

`SELECT details -> 'Adresse' ->> 'Ort' FROM rechnungen;`{{execute}}

Zur sicherheit gilt also: Bei mehreren Pfeilen in einer Abfrage darf immer nur der letzte mit doppeltem `>` geschrieben werden.
Alternativ zeigen dir auch die Gänsefüßschen `"` beim Ergebnis, dass es sich bei der Ergebnis um JSON(B)-Objekte handelt.

`SELECT details -> 'Adresse' -> 'Ort' FROM rechnungen;`{{execute}}

__Arrays__

Den Array mit allen Artikeln kannst du über folgende Abfrage auslesen:

`SELECT details -> 'Artikel' FROM rechnungen;`{{execute}}

Willst du einen speziellen Artikel, wird zusätzlich der Index (beginnend bei 0) angegeben. 

`SELECT details -> 'Artikel' -> 0 FROM rechnungen;`{{execute}}

PostgreSQL bietet dir auch die Möglichkeit, einen Array von hinten zu lesen (beginnend bei -1).

`SELECT details -> 'Artikel' -> -1 FROM rechnungen;`{{execute}}

Gar nicht so schwer oder?  
Dann gehts weiter zu den Aggregatfunktionen 🙌
