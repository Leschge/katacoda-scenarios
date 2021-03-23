DROP TABLE rechnungen;

CREATE TABLE rechnungen (rechnungsNr INT PRIMARY KEY, details JSONB);

INSERT INTO rechnungen (rechnungsNr, details) VALUES (23774, '{ 
	"Name":"Hans Peter", 
	"Datum":"22-03-2021 23:32:00", 
	"KundenNr": "2465433",
	"Artikel":[
		{ "Name": "Pullover", "Preis": "35.00", "Menge": "1" },
		{ "Name": "Socken", "Preis": "7.95", "Menge": "3" },
		{ "Name": "Jeans", "Preis": "65.99", "Menge": "1" }
	]
}');


INSERT INTO rechnungen (rechnungsNr, details) VALUES (23775, '{ 
	"Name":"Sabine Meerson", 
	"Datum":"22-03-2021 10:45:00", 
	"KundenNr": "2465434",
	"Artikel":[
		{ "Name": "Bluse", "Preis": "35.00", "Menge": "1" },
		{ "Name": "Schal", "Preis": "6.95", "Menge": "2" }
	]
}');



INSERT INTO rechnungen (rechnungsNr, details) VALUES (23776, '{ 
	"Name":"Michael Müller", 
	"Datum":"23-03-2021 13:32:00", 
	"KundenNr": "2465435",
	"Artikel":[
		{ "Name": "Hose", "Preis": "45.00", "Menge": "2" },
		{ "Name": "Shirt", "Preis": "24.99", "Menge": "3" },
		{ "Name": "Sneaker", "Preis": "95.99", "Menge": "1" }
	]
}');



INSERT INTO rechnungen (rechnungsNr, details) VALUES (23777, '{ 
	"Name":"Jonas Schell", 
	"Datum":"23-03-2021 19:03:00", 
	"KundenNr": "2465436",
	"Artikel":[
		{ "Name": "Shorts", "Preis": "35.00", "Menge": "2" }
	]
}');
