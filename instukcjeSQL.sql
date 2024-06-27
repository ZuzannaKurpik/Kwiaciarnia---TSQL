-- Diagram związków encji dla KWIACIARNI. Sklep oferuje możliwość zamówienia różnego rodzaju bukietów, które mogą
-- składać się z jednego, wielu lub wiązanki różnych kwiatów. Kupujący decyduje jakiego rodzaju kwiaty i w jakiej i
-- lości chce zamówić. Może to być bukiet skomponowany przez kupującego lub wybrany z oferty. Kupujący musi również
-- określić dodatki (przybranie, opakowanie). Baza danych sklepu rejestruje datę złożenia zamówienia, dane kupującego i
-- obliczoną cenę (na podstawie cen bieżących kwiatów i dodatków) widoczną dla kupującego (cena kwiatów moze się różnić
-- każdego dnia, a cena zamówienia jest obliczana na podstawie cen z dnia zamówienia). Kupujący musi również podać
-- adres i nazwisko adresata przesyłki, sugerowaną datę dostawy oraz treść liściku do bukietu. PO dostawie przesyłki
-- sklep zapamiętuje że zlecenie zostało zrealizowane. Sklep rejestruje również, czy kupujący dokonał wpłaty
-- na konto sklepu.

GO
DROP TABLE kwiat_bukiet;
GO
DROP TABLE cena_kwiat;
GO
DROP TABLE cena_dodatki;
GO
DROP TABLE kwiat;
GO
DROP TABLE bukiet_dodatki;
GO
DROP TABLE bukiet_zamówienie;
GO
DROP TABLE bukiet;
GO
DROP TABLE dodatki;
GO
DROP TABLE zamowienie;
GO
DROP TABLE klient;
GO
DROP TABLE adres;

GO
CREATE TABLE adres (
	ID				INTEGER PRIMARY KEY,
  	kod				VARCHAR(6) NOT NULL,
  	miasto			VARCHAR(30) NOT NULL,
  	ulica			VARCHAR(30) NOT NULL,
  	nr_budynku		INTEGER NOT NULL,
  	nr_mieszkania	INTEGER NULL
);

GO
CREATE TABLE klient (
	ID			INTEGER PRIMARY KEY,
  	imie		VARCHAR(30) NOT NULL,
  	nazwisko	VARCHAR(30) NOT NULL,
  	email		VARCHAR(30) NOT NULL
);

GO
CREATE TABLE zamowienie (
	ID					INTEGER PRIMARY KEY,
  	data				DATE NOT NULL,
  	klient_ID			INTEGER NOT NULL,
  	data_dostawy		DATE NOT NULL,
  	tresc_listu			VARCHAR(100) NOT NULL,
  	status				VARCHAR(20) NOT NULL,
  	czy_przelew			VARCHAR(3) NOT NULL,
  	adres_ID			INTEGER NOT NULL,
  	data_realizacji		DATE NOT NULL,
  	FOREIGN KEY (klient_ID) references klient,
  	FOREIGN KEY (adres_ID) references adres
);

GO
CREATE TABLE bukiet (
	ID		INTEGER PRIMARY KEY,
  	typ		VARCHAR(30) NOT NULL
);

GO
CREATE TABLE bukiet_zamówienie (
  	ID				INTEGER PRIMARY KEY,
	bukiet_ID		INTEGER NOT NULL,
  	zamowienie_ID	INTEGER NOT NULL,
  	ilosc			INTEGER NOT NULL,
  	FOREIGN KEY (bukiet_ID) references bukiet,
  	FOREIGN KEY (zamowienie_ID) references zamowienie
);

GO
CREATE TABLE kwiat (
	ID		INTEGER PRIMARY KEY,
  	nazwa	VARCHAR(30) NOT NULL
);

GO
CREATE TABLE kwiat_bukiet (
  	ID				INTEGER PRIMARY KEY,
	kwiat_ID		INTEGER NOT NULL,
  	bukiet_id		INTEGER NOT NULL,
  	ilosc			INTEGER NOT NULL,
  	FOREIGN KEY (kwiat_ID) references kwiat,
  	FOREIGN KEY (bukiet_ID) references bukiet
);

GO
CREATE TABLE cena_kwiat (
	ID			INTEGER PRIMARY KEY,
  	kwiat_ID	INTEGER NOT NULL,
  	cena		MONEY NOT NULL,
  	data		DATE NOT NULL,
  	FOREIGN KEY (kwiat_ID) references kwiat
);

GO
CREATE TABLE dodatki (
	ID			INTEGER PRIMARY KEY,
  	przybranie	VARCHAR(20) NOT NULL,
  	opakowanie	VARCHAR(30) NOT NULL
);

GO
CREATE TABLE bukiet_dodatki (
	ID			INTEGER PRIMARY KEY,
  	bukiet_ID	INTEGER NOT NULL,
  	dodatki_ID	INTEGER NOT NULL,
  	ilosc		INTEGER NOT NULL,
  	FOREIGN KEY (bukiet_ID) references bukiet,
  	FOREIGN KEY (dodatki_ID) references dodatki
);

GO
CREATE TABLE cena_dodatki (
	ID			INTEGER PRIMARY KEY,
  	dodatki_ID	INTEGER NOT NULL,
  	cena		MONEY NOT NULL,
  	data		DATE NOT NULL,
);

GO
INSERT INTO adres (ID, kod, miasto, ulica, nr_budynku, nr_mieszkania)
VALUES (1, '05800', N'Pruszków', N'Niecała', 5, 3)
GO
INSERT INTO adres (ID, kod, miasto, ulica, nr_budynku, nr_mieszkania)
VALUES (2, '05126', N'Stanisławów Pierwszy', N'Wesoła', 55, NULL);
GO
INSERT INTO adres (ID, kod, miasto, ulica, nr_budynku, nr_mieszkania)
VALUES (3, '52119', N'Wrocław-Krzyki', '3 maja', 10, 334);
GO
INSERT INTO adres (ID, kod, miasto, ulica, nr_budynku, nr_mieszkania)
VALUES (4, '70471', 'Szczecin', 'Al. Wojska Polskiego', 54, NULL);

GO
INSERT INTO klient (ID, imie, nazwisko, email)
VALUES (1, N'Małgorzata', 'Wojciechowska', 'madziaW@gmail.com');
GO
INSERT INTO klient (ID, imie, nazwisko, email)
VALUES (2, 'Eryk', 'Maciejak', 'dzika_bestai_5@gmial.com');
GO
INSERT INTO klient (ID, imie, nazwisko, email)
VALUES (3, 'Ola', 'Niezgoda', 'niezgodka@wp.pl');
GO
INSERT INTO klient (ID, imie, nazwisko, email)
VALUES (4, N'Bronisław', 'Kowalski', 'bronislawK@poczta.onet.pl');

GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (1, '2000-09-13', 3, '2000-09-20', 'Zdrowiej!!!', N'Ukończone', 'TAK', 2, '2000-09-15');
GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (2, '2023-11-17', 4, '2024-01-06', 'Wszystkiego Najlepszego', 'W trakcie', 'NIE', 4, '2023-11-19');
GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (3, '2023-11-20', 1, '2023-12-10', 'Pozdrowienia', 'W trakcie', 'NIE', 3, '2023-11-25');
GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (4, '2023-12-22', 2, '2024-01-08', N'Cześć', N'Nie ukończone', 'TAK', 4, '2023-12-27');
GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (5, '2024-01-24', 2, '2024-02-12', 'Witaj', 'W trakcie', 'NIE', 1, '2024-01-29');
GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (6, '2024-02-26', 4, '2024-03-10', N'Cześć', N'Ukończone', 'TAK', 1, '2024-03-01');
GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (7, '2024-03-15', 3, '2024-03-25', N'Gratulacje', N'Ukończone', 'TAK', 1, '2024-03-20');
GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (8, '2024-04-05', 1, '2024-04-20', N'Dziękuję', N'Nie ukończone', 'NIE', 2, '2024-04-10');
GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (9, '2024-05-01', 4, '2024-05-15', N'Powodzenia', N'W trakcie', 'NIE', 4, '2024-05-05');

GO
INSERT INTO bukiet (ID, typ) values (1, 'Dwukolorowy');
GO
INSERT INTO bukiet (ID, typ) values (2, 'Trzykolorowy');
GO
INSERT INTO bukiet (ID, typ) values (3, 'Mieszanka');
GO
INSERT INTO bukiet (ID, typ) values (4, N'Tęcza');
GO
INSERT INTO bukiet (ID, typ) values (5, N'Własny');

GO
INSERT INTO bukiet_zamówienie (ID, bukiet_ID, zamowienie_ID, ilosc)
VALUES (1, 4, 5, 3);
GO
INSERT INTO bukiet_zamówienie (ID, bukiet_ID, zamowienie_ID, ilosc)
VALUES (2, 2, 2, 2);
GO
INSERT INTO bukiet_zamówienie (ID, bukiet_ID, zamowienie_ID, ilosc)
VALUES (3, 1, 5, 1);
GO
INSERT INTO bukiet_zamówienie (ID, bukiet_ID, zamowienie_ID, ilosc)
VALUES (4, 5, 6, 10);
GO
INSERT INTO bukiet_zamówienie (ID, bukiet_ID, zamowienie_ID, ilosc)
VALUES (5, 3, 1, 5);
GO
INSERT INTO bukiet_zamówienie (ID, bukiet_ID, zamowienie_ID, ilosc)
VALUES (6, 2, 3, 20);

GO
INSERT INTO kwiat (ID, nazwa) VALUES (1, N'Goździk');
GO
INSERT INTO kwiat (ID, nazwa) VALUES (2, N'Róża');
GO
INSERT INTO kwiat (ID, nazwa) VALUES (3, 'Tulipan');
GO
INSERT INTO kwiat (ID, nazwa) VALUES (4, N'Słonecznik');
GO
INSERT INTO kwiat (ID, nazwa) VALUES (5, 'Piwonia');
GO
INSERT INTO kwiat (ID, nazwa) VALUES (6, 'Dalia');

GO
INSERT INTO cena_kwiat (ID, kwiat_ID, cena, data)
VALUES (1, 2, 40, '2020-01-01');
GO
INSERT INTO cena_kwiat (ID, kwiat_ID, cena, data)
VALUES (2, 1, 10, '2023-11-01');
GO
INSERT INTO cena_kwiat (ID, kwiat_ID, cena, data)
VALUES (3, 6, 58, '2002-02-20');
GO
INSERT INTO cena_kwiat (ID, kwiat_ID, cena, data)
VALUES (4, 4, 25, '2017-03-25');
GO
INSERT INTO cena_kwiat (ID, kwiat_ID, cena, data)
VALUES (5, 3, 10, '2011-11-11');
GO
INSERT INTO cena_kwiat (ID, kwiat_ID, cena, data)
VALUES (6, 5, 33, '2023-11-20');

GO
INSERT INTO kwiat_bukiet (ID, kwiat_ID, bukiet_ID, ilosc) VALUES (1, 5, 1, 5);
GO
INSERT INTO kwiat_bukiet (ID, kwiat_ID, bukiet_ID, ilosc) VALUES (2, 4, 4, 2);
GO
INSERT INTO kwiat_bukiet (ID, kwiat_ID, bukiet_ID, ilosc) VALUES (3, 3, 3, 3);
GO
INSERT INTO kwiat_bukiet (ID, kwiat_ID, bukiet_ID, ilosc) VALUES (4, 6, 5, 3);

GO
INSERT INTO dodatki (ID, przybranie, opakowanie)
VALUES (1, 'Brak', 'Brak');
GO
INSERT INTO dodatki (ID, przybranie, opakowanie)
VALUES (2, 'Premium', 'Plastikowe');
GO
INSERT INTO dodatki (ID, przybranie, opakowanie)
VALUES (3, 'Deluxe', 'Papierowe');
GO
INSERT INTO dodatki (ID, przybranie, opakowanie)
VALUES (4, 'Standardowe', 'Plastikowe');

GO
INSERT INTO bukiet_dodatki (ID, bukiet_ID, dodatki_ID, ilosc)
VALUES (1, 3, 1, 3)
GO
INSERT INTO bukiet_dodatki (ID, bukiet_ID, dodatki_ID, ilosc)
VALUES (2, 4, 4, 2)
GO
INSERT INTO bukiet_dodatki (ID, bukiet_ID, dodatki_ID, ilosc)
VALUES (3, 5, 2, 15)

--  [1]  Utwórz procedurę, która dla podanej wartości cena-kwiat zmodyfikuje wskazaną wartość na daną wartość (+ 10%) i przez
-- OUTPUT zwróci nową wartość cena-kwiat
CREATE PROCEDURE cena_kwiat_podwyzka
@ID INTEGER, @Data DATE, @Procent INTEGER = 10, @Info VARCHAR(50) OUTPUT
    AS DECLARE @New_cena MONEY;
    BEGIN
        SELECT @New_cena = ck.cena + ck.cena*@Procent /100
        FROM cena_kwiat ck
        WHERE ck.ID = @ID
        UPDATE cena_kwiat SET cena_kwiat.cena = @New_cena, cena_kwiat.data = @Data
        WHERE cena_kwiat.ID = @ID
        SET @Info = 'Zmieniono cenę kwiatu o numerze ' +CAST(@ID AS VARCHAR) + ' na ' +CAST(@New_cena AS VARCHAR)
    end

DECLARE @Nowa_cena_k VARCHAR(50)
EXECUTE cena_kwiat_podwyzka 1, '2023-11-20', DEFAULT, @Nowa_cena_k OUTPUT
PRINT @Nowa_cena_k


--  [2]  Procedura pozwalająca wstawić nowy kwiat do tabeli uprzednio sprawdzający czy już taki rekord nie istnieje.
-- jeżeli nie to poinformuje użytkownika o tym fakcje. pomyślen wstawianie również zostanie zakończone komunikatem
CREATE PROCEDURE wstawKwiat
    @Nazwa VARCHAR(30)
    AS BEGIN
        DECLARE @count INT, @index INT
        SELECT @count = COUNT(*) FROM kwiat k WHERE k.nazwa = @Nazwa
        SELECT @index = COUNT(*) FROM kwiat
        if @count = 0
        BEGIN
            INSERT INTO kwiat (ID, nazwa)
            VALUES (@index +1, @Nazwa)
            PRINT 'Dodano nowy kwiat o nazwie ' +CAST(@Nazwa AS VARCHAR)
        END
        else
            PRINT 'Podany kwiat już jest w systemie'
end

EXECUTE wstawKwiat 'Storczyk'


--  [3]  Procedura pobierająca parametr z pudżet oraz ilość jaką pragnie klient
-- kupić. następnie wyświtli te kwiaty które mieszczą się w budżecie (nazwę i cene za sztukę)
-- oraz ile reszty klient dostanie
CREATE PROCEDURE czyWystarczy
    @budget MONEY, @Ilosc INT
    AS BEGIN
    SELECT k.nazwa AS Nazwa,
           ck.cena AS Cena,
           @budget - SUM(ck.cena*@Ilosc) AS Budget
    FROM kwiat k INNER JOIN cena_kwiat ck on k.ID = ck.kwiat_ID
    WHERE ck.cena*@Ilosc <= @budget
    GROUP BY k.nazwa, ck.cena
end

EXEC czyWystarczy 200, 6


--  [4]  Procedura sprawdzająca czy dany klient istnieje. jeżeli tak to wyświetli komunikat
-- jeżeli nie to również wyświetli komunikat i doda go do bazy. klient podaje do
-- procedury imie, nazwisko, email. procedura będzie sprawdzać klientów po adresie email
CREATE PROCEDURE sprawdzKlienta
    @Name VARCHAR(30), @Last VARCHAR(30), @Email VARCHAR(30)
    AS BEGIN
    DECLARE @clID INT
    SET @clID = (SELECT MAX(ID) FROM klient) +1;

    if NOT EXISTS(SELECT 1 FROM klient where email = @Email)
    BEGIN
        PRINT 'Podany klient nie istenie. Dodawanie do bazy...';
        INSERT INTO klient (ID, imie, nazwisko, email)
        VALUES (@clID, @Name, @Last, @Email)
        PRINT 'Dodano nowego klienta na pozycji : ' + CAST(@clID AS VARCHAR)
    end
    ELSE
    BEGIN
        PRINT 'Taki klient juz istenie'
        SELECT * FROM klient WHERE email = @Email
    end
end

EXEC sprawdzKlienta N'Małgorzata', 'Wojciechowska', 'madziaW@gmail.com'


--  [1] Wyzwalacz który sprawdzi czy status i przelew zamówienia w razie usunięcia
-- rekordu z tabeli nie dopuści do jego usunięsia jeżeli status lub przelew nie jest
-- skończone
CREATE TRIGGER usuwanieZamowienia
    ON zamowienie AFTER DELETE AS BEGIN
        SET NOCOUNT ON;
        DECLARE @usunID INT;
        SELECT @usunID = ID FROM deleted;

        if EXISTS(SELECT 1 FROM deleted WHERE status != 'Ukończone' OR czy_przelew != 'TAK')
        begin
            RAISERROR ('Nie można usunąć nie opłaconego i nie ukończonego zamówienia ! ! !', 16, 1)
        end else begin
            DELETE FROM zamowienie WHERE ID = @usunID
        end
end

DELETE FROM zamowienie WHERE ID = 2;


--  [2] cena zamówienia
ALTER TABLE zamowienie ADD wartosc MONEY

CREATE TRIGGER cenaZamowienia
    ON zamowienie AFTER INSERT, UPDATE AS BEGIN
    DECLARE @zamow_ID INTEGER, @buk_ID INTEGER, @ilosc INTEGER
    DECLARE zamowCURSOR CURSOR FOR
        SELECT zamowienie.ID, bukiet_ID, ilosc
        FROM zamowienie INNER JOIN bukiet_zamówienie bz on zamowienie.ID = bz.zamowienie_ID
    OPEN zamowCURSOR
    FETCH NEXT FROM zamowCURSOR INTO @zamow_ID, @buk_ID, @ilosc

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @cena_bukiet MONEY
        SELECT @cena_bukiet = ck.cena
        FROM cena_kwiat CK
        WHERE ck.kwiat_ID = (
                SELECT kb.kwiat_ID
                FROM kwiat_bukiet kb
                WHERE kb.bukiet_id = @buk_ID
            )
        DECLARE @cena_zamowienie MONEY
        SELECT @cena_zamowienie = @cena_bukiet * @ilosc

        UPDATE zamowienie
        SET wartosc = @cena_zamowienie
        WHERE ID = @zamow_ID

        if @cena_zamowienie > 500
        begin
            declare @rabat money
            set @rabat = @cena_zamowienie * 0.1
                update zamowienie
                set wartosc = @cena_zamowienie - @rabat
                where ID = @zamow_ID
        end
        FETCH NEXT FROM zamowCURSOR INTO @zamow_ID, @buk_ID, @ilosc
    end
    close zamowCURSOR
    deallocate zamowCURSOR
end

GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (7, '2024-04-01', 1, '2024-04-10', 'Test rabatu', 'W trakcie', 'NIE', 1, '2024-04-05');
GO
INSERT INTO bukiet_zamówienie (zamowienie_ID, bukiet_ID, ilosc)
VALUES (7, 1, 5);


--  [3] Aktualizacja statusu zamówienia który sprawdza datę zamówienia i w zależności
--  od tego czy data dostawy już mineła czy jest w ciągu dwóch dni od aktualnej
-- daty.
CREATE TRIGGER AktualizacjaStatusuZamowienia
ON zamowienie AFTER INSERT, UPDATE AS BEGIN
    SET NOCOUNT ON
    DECLARE @zamow_ID INTEGER, @data_dostawy DATE, @status VARCHAR(30)
    DECLARE zamowCURSOR CURSOR FOR
        SELECT ID, data_dostawy, status
        FROM inserted

    OPEN zamowCURSOR
    FETCH NEXT FROM zamowCURSOR INTO @zamow_ID, @data_dostawy, @status

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @data_dostawy <= GETDATE()
        BEGIN
            UPDATE zamowienie
            SET status = 'Dostarczone'
            WHERE ID = @zamow_ID
        end ELSE IF @data_dostawy <= DATEADD(DAY, 2, GETDATE())
        BEGIN
            UPDATE zamowienie
            SET status = 'W trakcie dostawy'
            WHERE ID = @zamow_ID
        end ELSE BEGIN
            UPDATE zamowienie
            SET status = 'Przyjete'
            WHERE ID = @zamow_ID
        end
        FETCH NEXT FROM zamowCURSOR INTO @zamow_ID, @data_dostawy, @status
    end
    CLOSE zamowCURSOR
    DEALLOCATE zamowCURSOR
end

GO
INSERT INTO zamowienie (ID, data, klient_ID, data_dostawy, tresc_listu, status, czy_przelew, adres_ID, data_realizacji)
VALUES (8, '2024-03-01', 2, '2024-03-03', 'Test statusu', 'W trakcie', 'TAK', 3, '2024-03-02');
