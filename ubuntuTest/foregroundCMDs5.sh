DROP TABLE rechnungen;

CREATE TABLE rechnungen (rechnungsNr INT PRIMARY KEY, details JSONB);

INSERT INTO rechnungen (rechnungsNr, details) VALUES (23774, '{ 
	"Name": "Hans Peter", 
	"Datum": "22-03-2021 23:32:00", 
	"KundenNr": "2465433",
	"Adresse": { "Strasse": "Silberalle 12", "PLZ": "73357", "Ort": "München" },
	"Artikel":[
		{ "Name": "Pullover", "Preis": "35.00" },
		{ "Name": "Socken", "Preis": "7.95" },
		{ "Name": "Jeans", "Preis": "65.99" }
	]
}');


INSERT INTO rechnungen (rechnungsNr, details) VALUES (23775, '{ 
	"Name": "Michelle Seeger", 
	"Datum": "22-03-2021 10:45:00", 
	"KundenNr": "2465434",
	"Adresse": { "Strasse": "Rotebühlplatz 40", "PLZ": "74211", "Ort": "Stuttgart" },
	"Artikel":[
		{ "Name": "Bluse", "Preis": "35.00" },
		{ "Name": "Schal", "Preis": "6.95" }
	],
	"PremiumKunde": "true"
}');



INSERT INTO rechnungen (rechnungsNr, details) VALUES (23776, '{ 
	"Name": "Michael Müller", 
	"Datum": "23-03-2021 13:32:00", 
	"KundenNr": "2465435",
	"Adresse": { "Strasse": "Winkelgasse 9", "PLZ": "83711", "Ort": "Konstanz" },
	"Artikel":[
		{ "Name": "Hose", "Preis": "45.00" },
		{ "Name": "Shirt", "Preis": "24.99" },
		{ "Name": "Socken", "Preis": "7.95" }
	],
	"PremiumKunde": "true"
}');



INSERT INTO rechnungen (rechnungsNr, details) VALUES (23777, '{ 
	"Name": "Jonas Schell", 
	"Datum": "23-03-2021 19:03:00", 
	"KundenNr": "2465436",
	"Adresse": { "Strasse": "Tempelstrasse 78", "PLZ":"25733", "Ort": "Berlin" },
	"Artikel":[
		{ "Name": "Socken", "Preis": "9.99" }
	]
}');


\! clear
