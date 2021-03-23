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

Alle Namen kannst du also mit folgender Abfrage ausgeben:
`SELECT details ->> 'Name' FROM rechnungen;`{{execute}}

Ist dir aufgefallen, dass mehr Namen hinzugekommen sind?  
Die haben wir lediglich zum besseren Testen heimlich hinzugefügt.  
Klicke auf die Datei unten um dir einen besseren Überblick über die Daten zu beschaffen:

`rechnungen.js`{{open}} 


### Verkettete Abfragen

Wie du sehen kannst ist ebenfalls die Adresse hinzugekommen, wir möchten alle eingetragene Orte im System ausgeben, dafür benötigen wir einen verkettete Abfrage:
`SELECT details ->> 'Adresse' ->> 'Ort' FROM rechnungen;`{{execute}}

Vermutlich bekommst du den Fehler `ERROR: operator does not exist: text ->> ...`, kannst du dir vorstellen weshalb?  
Für eine verschachtelte Abfrage müssen wir mit dem JSON(B) Operator arbeiten:
`SELECT details -> 'Adresse' ->> 'Ort' FROM rechnungen;`{{execute}}

Zur sicherheit gilt also: Bei mehreren Pfeilen in einer Abfrage darf immer nur der letzte mit doppeltem `>` geschrieben werden.
Alternativ zeigen dir auch die doppelten Gänsefüßschen `"` beim Ergebnis, dass es sich gerade um JSON(B)-Objekte handelt.
`SELECT details -> 'Adresse' -> 'Ort' FROM rechnungen;`{{execute}}
