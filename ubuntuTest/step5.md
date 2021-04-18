Damit wir das `WHERE`-Statement schneller benutzen können, sind ein paar weitere Einträge in unserer "rechnungen"-Tabelle hinzugekommen.  
Klicke auf die Datei unten, wenn du dir einen besseren Überblick über die neuen Daten in der Tabelle beschaffen willst:

`StrukturRechnungen.js`{{open}} 

### Einfache WHERE Bedingung

Du möchtest beispielsweise für alle Rechnungen, die nach dem 22.03.2021 erstellt wurden, den Namen und das Datum ausgeben.
Dafür benutzt du deine bisherigen SQL Kenntnisse einfach zusammen mit dem eben gelernten.
Die Abfrage sieht dann so aus:

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

Und schon bist du beim letzten Schritt,  
den Indizes😊
