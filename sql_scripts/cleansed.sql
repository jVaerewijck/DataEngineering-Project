
-- Schema aanmaken indien het nog niet bestaat
CREATE SCHEMA IF NOT EXISTS cleansed;

-- Tabellen verwijderen indien ze bestaan
DROP TABLE IF EXISTS cleansed.aankomst, cleansed.banen, cleansed.klant, cleansed.luchthavens, cleansed.maatschappijen, cleansed.planning, cleansed.vertrek, cleansed.vliegtuig, cleansed.vliegtuigtype, cleansed.vlucht, cleansed.weer CASCADE;


CREATE TABLE cleansed.aankomst (
    "Vluchtid" INT,         -- 6 karakters lang, gebaseerd op de langste waarde 936013
    "Vliegtuigcode" VARCHAR(10),    -- 6 karakters lang, zoals VKL859
    "Terminal" VARCHAR(1),         -- 1 karakter lang, zoals A, B, C
    "Gate" VARCHAR(2),             -- 2 karakters lang, zoals C1, A2
    "Baan" SMALLINT,             -- 1 karakter lang, voor de baan nummers
    "Bezetting" SMALLINT,        -- Maximaal 3 karakters, voor getallen zoals 71
    "Vracht" SMALLINT,           -- Lijkt leeg te zijn in de dataset, maar reserveer 1 karakter voor consistentie
    "Aankomsttijd" TIMESTAMP     -- Datum en tijd in het formaat "YYYY-MM-DD HH:MM:SS"
);


CREATE TABLE cleansed.banen (
    "Baannummer" SMALLINT,      -- 1 karakter lang, voor baannummers 1-6
    "Code" VARCHAR(7),            -- 7 karakters lang, zoals '18R-36L'
    "Naam" VARCHAR(30),           -- Geschatte lengte voor namen zoals 'Stépan Breedveldbaan'
    "Lengte" SMALLINT           -- 4 karakters lang, voldoende voor getallen zoals 3600
);

CREATE TABLE cleansed.klant (
    "Vluchtid" INT,      -- 7 karakters lang, gebaseerd op de langste waarde 1317406
    "Operatie" NUMERIC,      -- 3 karakters lang, bijv. '7.2'
    "Faciliteiten" NUMERIC,  -- 3 karakters lang, bijv. '8.5'
    "Shops" NUMERIC          -- 3 karakters lang, maximaal nodig voor getallen zoals '6.9'
);


CREATE TABLE cleansed.luchthavens (
    "Airport" VARCHAR(100),     -- Geschatte lengte voor namen zoals 'Bamyan Airport'
    "City" VARCHAR(100),        -- Geschatte lengte voor stadsnamen zoals 'Bamyan'
    "Country" VARCHAR(100),     -- Geschatte lengte voor landnamen zoals 'Afghanistan'
    "IATA" VARCHAR(100),         -- 3 karakters, bijv. 'BIN'
    "ICAO" VARCHAR(100),         -- 4 karakters, bijv. 'OABN'
    "Lat" NUMERIC,         -- Lengte voor breedtegraden zoals '34.816667'
    "Lon" NUMERIC,         -- Lengte voor lengtegraden zoals '67.816667'
    "Alt" SMALLINT,          -- 4 karakters voor hoogte zoals '2550'
    "TZ" NUMERIC,           -- 4 karakters voor tijdzone offset zoals '4.5'
    "DST" VARCHAR(1),          -- 1 karakter voor DST, bijv. 'N'
    "Tz" VARCHAR(100)           -- Geschatte lengte voor tijdzone namen zoals 'Asia/Kabul'
);


CREATE TABLE cleansed.maatschappijen (
    "Name" VARCHAR(50),     -- Voldoende lengte om namen zoals "Tom's & co airliners" te bevatten
    "IATA" VARCHAR(3),      -- 3 karakters, rekening houdend met bijzondere invoeren zoals '&T'
    "ICAO" VARCHAR(3)       -- 3 karakters, voor standaard ICAO codes, zelfs met invoeren zoals 'N/A' of '\N'
);

CREATE TABLE cleansed.planning (
    "Vluchtnr" VARCHAR(10),      -- 6 karakters lang, genoeg voor waarden zoals '9W2888'
    "Airlinecode" VARCHAR(4),   -- 2 karakters lang, zoals '9W'
    "Destcode" VARCHAR(3),      -- 3 karakters, standaard IATA luchthaven codes zoals 'DEL'
    "Planterminal" VARCHAR(1),  -- 1 karakter, zoals 'D'
    "Plangate" VARCHAR(2),      -- 2 karakters, zoals 'D2'
    "Plantijd" TIME       -- 8 karakters, ruimte voor tijden zoals '2:10 PM'
);

CREATE TABLE cleansed.vertrek (
    "Vluchtid" INT,         -- 6 karakters lang, gebaseerd op de langste waarde 936013
    "Vliegtuigcode" VARCHAR(10),    -- 6 karakters lang, zoals VKL859
    "Terminal" VARCHAR(1),         -- 1 karakter lang, zoals A, B, C
    "Gate" VARCHAR(2),             -- 2 karakters lang, zoals C1, A2
    "Baan" SMALLINT,             -- 1 karakter lang, voor de baan nummers
    "Bezetting" SMALLINT,        -- Maximaal 3 karakters, voor getallen zoals 71
    "Vracht" SMALLINT,           -- Lijkt leeg te zijn in de dataset, maar reserveer 1 karakter voor consistentie
    "Vertrektijd" TIMESTAMP    -- Datum en tijd in het formaat "YYYY-MM-DD HH:MM:SS", zoals '2014-01-01 03:33:00'
);


CREATE TABLE cleansed.vliegtuig (
    "Airlinecode" VARCHAR(5),     -- 2 karakters lang, zoals 'TK'
    "Vliegtuigcode" VARCHAR(10),   -- 7 karakters lang, zoals 'VDL5829'
    "Vliegtuigtype" VARCHAR(5),   -- 3 karakters lang, voor typeaanduidingen zoals '321'
    "Bouwjaar" SMALLINT         -- 4 karakters lang, voor het bouwjaar zoals '1970'
);

CREATE TABLE cleansed.vliegtuigtype (
    "IATA" VARCHAR(10),        -- 3 karakters lang, zoals '100'
    "ICAO" VARCHAR(10),        -- 4 karakters lang, zoals 'F100'
    "Merk" VARCHAR(30),       -- Geschatte lengte voor merknamen zoals 'British Aerospace'
    "Type" VARCHAR(100),       -- Geschatte lengte voor types zoals 'BAe 146-200 Pax'
    "Wake" VARCHAR(5),        -- 1 karakter, categorie van de wake turbulence, zoals 'M'
    "Cat" VARCHAR(510),         -- 3 karakters, categorie van het vliegtuiggebruik, zoals 'Pax'
    "Capaciteit" SMALLINT,  -- 3 karakters, voor capaciteit zoals '115'
    "Vracht" SMALLINT       -- Voldoende voor kleine getallen zoals '5'
);

CREATE TABLE cleansed.vlucht (
    "Vluchtid" INT,        -- 6 karakters lang, zoals '935995'
    "Vluchtnr" VARCHAR(10),        -- 6 karakters lang, zoals 'EZY741'
    "Airlinecode" VARCHAR(5),     -- 3 karakters lang, zoals 'EZY'
    "Destcode" VARCHAR(5),        -- 3 karakters, voor luchthavencodes zoals 'ACE'
    "Vliegtuigcode" VARCHAR(10),   -- 7 karakters lang, zoals 'VEZY741'
    "Datum" DATE           -- Datum in het formaat "YYYY-MM-DD", zoals '2014-01-01'
);

CREATE TABLE cleansed.weer (
    "Datum" DATE,     -- Datum in het formaat "YYYY-MM-DD"
    "DDVEC" SMALLINT,      -- Windrichting in graden
    "FHVEC" SMALLINT,      -- Uurgemiddelde windsnelheid (in 0.1 m/s)
    "FG" SMALLINT,         -- Daggemiddelde windsnelheid (in 0.1 m/s)
    "FHX" SMALLINT,        -- Maximale uurgemiddelde windsnelheid (in 0.1 m/s)
    "FHXH" SMALLINT,       -- Uurvak van maximale uurgemiddelde windsnelheid
    "FHN" SMALLINT,        -- Minimale uurgemiddelde windsnelheid (in 0.1 m/s)
    "FHNH" SMALLINT,       -- Uurvak van minimale uurgemiddelde windsnelheid
    "FXX" SMALLINT,        -- Maximale windstoot (in 0.1 m/s)
    "FXXH" SMALLINT,       -- Uurvak van maximale windstoot
    "TG" SMALLINT,         -- Daggemiddelde temperatuur (in 0.1 graden Celsius)
    "TN" SMALLINT,         -- Minimum temperatuur (in 0.1 graden Celsius)
    "TNH" SMALLINT,        -- Tijdvak van minimum temperatuur
    "TX" SMALLINT,         -- Maximum temperatuur (in 0.1 graden Celsius)
    "TXH" SMALLINT,        -- Tijdvak van maximum temperatuur
    "T10N" SMALLINT,       -- Minimum temperatuur op 10 cm hoogte (in 0.1 graden Celsius)
    "T10NH" SMALLINT,      -- Tijdvak van minimum temperatuur op 10 cm hoogte
    "SQ" SMALLINT,         -- Zonneschijnduur (in 0.1 uur) berekend uit globale straling
    "SP" SMALLINT,         -- Percentage van de langst mogelijke zonneschijnduur
    "Q" SMALLINT,          -- Globale straling (in J/cm2)
    "DR" SMALLINT,         -- Duur van de neerslag (in 0.1 uur)
    "RH" SMALLINT,         -- Neerslaghoeveelheid (in 0.1 mm)
    "RHX" SMALLINT,        -- Maximum uur-neerslaghoeveelheid (in 0.1 mm)
    "RHXH" SMALLINT,       -- Uurvak van maximum uur-neerslaghoeveelheid
    "PG" SMALLINT,         -- Daggemiddelde luchtdruk (in 0.1 hPa)
    "PX" SMALLINT,         -- Maximum luchtdruk (in 0.1 hPa)
    "PXH" SMALLINT,        -- Uurvak van maximum luchtdruk
    "PN" SMALLINT,         -- Minimum luchtdruk (in 0.1 hPa)
    "PNH" SMALLINT,        -- Uurvak van minimum luchtdruk
    "VVN" SMALLINT,        -- Minimum zicht
    "VVNH" SMALLINT,       -- Uurvak van minimum zicht
    "VVX" SMALLINT,        -- Maximum zicht
    "VVXH" SMALLINT,       -- Uurvak van maximum zicht
    "NG" SMALLINT,         -- Gemiddelde bewolking (in achtsten, van 0 tot 9)
    "UG" SMALLINT,         -- Gemiddelde relatieve vochtigheid (in procenten)
    "UX" SMALLINT,         -- Maximum relatieve vochtigheid (in procenten)
    "UXH" SMALLINT,        -- Uurvak van maximum relatieve vochtigheid
    "UN" SMALLINT,         -- Minimum relatieve vochtigheid (in procenten)
    "UNH" SMALLINT,        -- Uurvak van minimum relatieve vochtigheid
    "EV2" SMALLINT         -- Potentiële verdamping (in 0.1 mm)
);
