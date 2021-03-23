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
Ein Beispiel für einen Verkettente
```
'{"a": "value"}'::json->'a'  = "value"
```

Alle Namen kannst du also mit folgender Abfrage ausgeben:
`SELECT details -> 'Name' FROM rechnungen;`{{execute}}
Ist dir aufgefallen, dass mehr Namen hinzugekommen sind?
Die haben wir lediglich zum besseren Testen heimlich hinzugefügt.
Klicke auf die Datei unten um dir einen besseren Überblick zu beschaffen:

`rechnungen.js`{{open}} 

Übersicht aller Tabellen:
`\dt+`
