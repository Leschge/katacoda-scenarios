Zu Beginn solltest du dir diese Frage stellen:

## Wann sollte ich JSON in Datenbanken verwenden? 🤔
Bevor du anfängst absofort alle Benutzerkonten und Statistiken im JSON-Format in Datenbanken zu speichern, solltest du dir gut überlegen, wann es tatsächlich sinnvoll ist das JSON-Format zu benutzen. In der Mehrheit alle Fälle sind nämlich relationale Datenstrukturen einfacher zu verwalten, da JSON-Einträge oft schwieriger sind abzufragen und zu bearbeiten. Bei deiner Entscheidung können dir die folgenden Fragen helfen ...

### Welchen Datentyp möchtest du speichern? 
JSON kann lediglich Daten als String abspeichern, weshalb du bei verschiedenen Abfragen oder Abfragen mit Aggregationen den Datentyp zuvor konvertieren musst. Verwendet deine Anwendung allerdings das komplette JSON direkt, kann es oft praktisch sein. Das JSON-Format lässt sich zum Beispiel in vielen Programmiersprachen einfach in deren Objekte deserialisieren. Ein anderes Beispiel sind benutzererstellte Daten wie Formulare die mit JSON-Werten (vor-)ausgefüllt werden müssen.  
Konkret lässt sich also sagen, dass besonders Anwendungen die Daten erzeugen, aber auch im selben Format einlesen, vom JSON-Format profitieren können.

### Wie strukturiert sind deine Daten?
Sind deine Daten strukturiert und einheitlich, eignen sich normale Tabellen oft besser. Sind sie allerdings nicht immer strukturier oder es ist dir gar nicht möglich die Struktur im vorhinein zu kennen, kann das JSON-Format Abhilfe beschaffen. Beispielsweise ist es sehr schwierig Fehler aus Programmen zu protokollieren, da diese meist beliebig oft verschachtelt sind. Ein anderes Beispiel sind IoT- oder Pilotenprojekte bei denen sich die Datenstruktur noch ändern kann. Sollten neue Daten hinzukommen, so genügt es  ein neues Feld an den JSON-String anzufügen, statt eine komplett neue Tabelle zu erstellen.

### Wie stark sind deine Daten miteinander verknüpft?
Der letzte und wohl wichtigste Punkt ist die Modelierung von Beziehungen im JSON-Format. Ist die Mehrzahl deiner Daten getrennt aber untereinander verknüpft und strukturiert, eignen sich relationale Datenbanken offensichtlich am besten. Sie sind dafür konzipiert einzelne Einträge aus verschiedenen Tabellen als Ganzes auszugeben und bieten demensprechend mächtige aber einfache Abfragen an.  
Das JSON-Format hingegen ist besonders gut für Verschachtelungen innerhalb des JSON-Formats, aber eben nicht für getrennt erstellte Daten geeignet. Sind die Daten verknüpft, in ihrer Erzeugung jedoch getrennt, sollte man diese wie bei relationalen Datenbanken normalisieren. Im JSON-Format ist jedes Kind und somit jeder Datenbankeintrag ein eigener JSON-String, beziehungsweise Dokument. Dieser wird über ein zusätzlicher Schlüssel zum Elternteil verknüpft. Die Verwendung vom JSON-Format ist bei einer getrennten Datenerzeugung aber eher unkonventionell, weshalb hier eventuell relationale Datenbanken bevorzugt werden sollten.

Nachfolgend sind nochmal zwei Beispiele zur Verdeutlichung.  

__Die Normalform__
```
Schlüssel = rechnung::1
{ "Name":"Hans Peter", "Datum":22-03-2021 23:32:00", "KundenNr": "2465433" }

Schlüssel = adresse:64
{ "KundenNr":"2465433", "Name": "Jeans, "Preis": "65.99" }

Schlüssel = artikel:884
{ "Rechnung":"1", "Name": "Pullover, "Preis": "35.00" }

Schlüssel = artikel:889
{ "Rechnung":"1", "Name": "Socken, "Preis": "7.95" }

Schlüssel = artikel:882
{ "Rechnung":"1", "Name": "Jeans, "Preis": "65.99" }
```

__Verschachtelt__
```
Schlüssel = rechnung::1
{ 
	"Name":"Hans Peter", 
	"Datum":"22-03-2021 23:32:00", 
	"KundenNr": "2465433",
	"Adresse": { "Strasse": "Silberalle 12", "PLZ": "73357","Ort": "München" },
	"Artikel":[
		{ "Name": "Pullover", "Preis": "35.00" },
		{ "Name": "Socken", "Preis": "7.95" },
		{ "Name": "Jeans", "Preis": "65.99" }
	]
}
```

Zusätzlich zum Beispiel ist hier noch eine Faustregel, wann verknüpfte Daten wie im JSON-Format gespeichert werden sollten.
Die Bedingung zeigt immer die Art der Datenbeziehung oder wie die Daten gelesen bzw. gespeichert werden.

| Bedingung | Format |
| ------------- |:-------------:|
| 1 zu 1 oder 1 zu M Beziehung      | Verschachtelte Objekte |
| M zu 1 oder M zu N Beziehung    | Einzelne Dokumente      |
| Nur Elternfelder werden gelesen | Einzelne Dokumente |
| Elternfelder und Kindfelder werden gleichzeitig gelesen | Verschachtelte Objekte |
| Entweder Elternfelder oder Kinderfelder werden gelesen | Einzelne Dokumente |
| Elterfelder werden mit Kinderfelder gespeichert | Verschachtelte Objekte |




__Puh! Das war ganz schön viel Theorie!__

Jetzt geht's endlich zum praktischen Teil 🎉
