# Kwiaciarnia
Jest to projekt napisany w 3 semestrze studiów. Przedstawia baze danych dla kwiaciarni. 
Zawiera w sobie wszystkie instrukcie CREATE oraz INSERT przykładowych danych. 

Wyzwalacze :
  - Wyzwalacz który sprawdzi czy status i przelew zamówienia w razie usunięcia rekordu
z tabeli nie dopuści do jego usunięsia jeżeli status lub przelew nie jestskończone
  - Liczenie ceny zamówienia
  - Aktualizacja statusu zamówienia sprawdzając datę zamówienia.

Proceduty :
  - Procedura, która dla podanej wartości cena-kwiat zmodyfikuje wskazaną wartość na daną
wartość (+ 10%) i przez OUTPUT zwróci nową wartość cena-kwiat;
  - Procedura pozwalająca wstawić nowy kwiat do tabeli uprzednio sprawdzający czy już
taki rekord nie istnieje.jeżeli nie to poinformuje użytkownika o tym fakcje. pomyślen
wstawianie również zostanie zakończone komunikatem;
  - Procedura pobierająca parametr z pudżet oraz ilość jaką pragnie klient kupić. następnie
 wyświtli te kwiaty które mieszczą się w budżecie (nazwę i cene za sztukę) oraz ile reszty
klient dostanie
  - Procedura sprawdzająca czy dany klient istnieje. jeżeli tak to wyświetli komunikat
jeżeli nie to również wyświetli komunikat i doda go do bazy. klient podaje do
procedury imie, nazwisko, email. procedura będzie sprawdzać klientów po adresie email



