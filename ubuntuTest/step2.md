__Hinweis:__
In diesem Tutorial verwenden wir den von Postgres zur Verfügung gestellten Datentyp _jsonb_. 
Dieser ist im Gegensatz zu _json_ deutlich schneller und ermöglicht die Indexierung von Einträgen.
Einzige Nachteile sind, dass _jsonb_ keine Leerzeichen speichert, keine doppelten Schlüssel erlaubt und die Reihenfolge der Einträge varieren kann.



### Tabelle erzeugen
Wir wollen Rechnungen speichern, da eine Rechnung gleichzeitig immer alle Artikel listet, verwenden wir das verschachtelte Prinzip. (Siehe Tabelle von Schritt 1)  
Bevor wir Einträge hinzufügen können, benötigen wir zuerst eine Tabelle.

Erstelle eine neue Tabelle "rechnungenJson" mit dem Feld "rechnugnsNr" (Schlüssel [int]) und "rechnung" (JSON):
`CREATE TABLE rechnungen (rechnungsNr INT PRIMARY KEY, rechnung JSON);`{{execute}}

Überprüfe ob deine Tabelle erfolgreich erstellt wurde:
`\d rechnungen;`{{execute}}

### Einträge hinzufügen
Wir wollen nun eine Rechnungen hinzufügen.
```
rechnungsNr = 236774
{ 
	"Name":"Hans Peter", 
	"Datum":"22-03-2021 23:32:00", 
	"KundenNr": "2465433",
	"Artikel":[
		{ "Name": "Pullover", "Preis": "35.00", "Menge": "1" },
		{ "Name": "Socken", "Preis": "7.95", "Menge": "3" },
		{ "Name": "Jeans", "Preis": "65.99", "Menge": "1" }
}
```


`INSERT INTO rechnungen (rechnungsNr,rechnung) VALUES (236774,'{ 
	"Name":"Hans Peter", 
	"Datum":"22-03-2021 23:32:00", 
	"KundenNr": "2465433",
	"Artikel":[
		{ "Name": "Pullover", "Preis": "35.00", "Menge": "1" },
		{ "Name": "Socken", "Preis": "7.95", "Menge": "3" },
		{ "Name": "Jeans", "Preis": "65.99", "Menge": "1" }
}');`{{execute}}


Mache dich am besten mit den JSON Dateien vertraut, die wir für dieses Tutorial verwenden werden.
Öffne sie einfach, indem du auf die unteren Links klickst.

`data.json`{{open}} 

`example.json`{{open}} 

Übersicht aller Tabellen:
`\dt+`
