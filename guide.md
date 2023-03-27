# Zalecenia Stylistyczne Kodu

Na sam początek chciałbym zaznaczyć że ten dokument nie jest w stanie końcowym, może się zmienić (i będzie się zmieniał).
Jest to zbiór rzeczy na które natknąłem się w trakcie refactora,
póki co bez struktury ale zamierzam to jakoś lepiej zorganizować jak się rozrośnie.

Stosowanie się do zaleceń **nie jest** obowiązkowe,
używajcie zdrowego rozsądku tam gdzie trzeba.

## 1. Wstawianie przecinków

To jest **najważniejszy** podpunkt ze wszystkich w tym dokumencie.

Staramy się dodawać jak najwięcej przecinków, żeby zachować czytelność.

- W każdej linijce ma być **maksymalnie** jedno zamknięcie nawiasu od konstruktora.
- Jeśli widget posiada więcej niż jeden parametr to rozbijamy go na kilka linijek.

Przykłady:

```dart
//Źle
Center(
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Text(translations.h_ride_details,
      style: const TextStyle(fontSize: 30)))),

//Dobrze
Center(
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Text(
      translations.h_ride_details,
      style: const TextStyle(fontSize: 30),
    ), // Text
  ), // Container
), // Center

```

Te komentarze na końcu widgetu dodawanie są automatycznie przez vscode jako pomoc wizualna i tak naprawdę nie ma ich w pliku.

## 2. `child` jako ostatni element

Cieżko jest opracować jedną standardową kolejność argumentów w widgecie. Dlatego najlepiej jest trzymać się zasady, że `child` jest **zawsze** na końcu widgetu, ponieważ jest to przeważnie największy widget i zawiera dużo zagnieżdzeń a nad nim dajemy arguemntu definiujące wygląd widgetu.

Ogólnie, krótkie pola typu wartości liczbowe na początek, potem rzeczy dłuższe typu `style` albo `shape`, a na koniec dajemy `child`. Funkcje jeśli są długie to lepiej zdefiniować poza `build()` i potem przekazać nazwę funkcji do widgetu ale to już według uznania.

## 3. Używanie super

Absolutnie nie wołamy `super()` w taki sposób:

```dart
const RideDetailsPage({Key? key}) : super(key: key);
```

Jest to stary syntax który został zastąpiony przez:

```dart
const RideDetailsPage({super.key});
```

To nie znaczy że nie powinniśmy w ogóle korzystać z `:` w konstruktorze. Można z niego korzystać na przykład do zmiennych obliczanych oraz assertów.

```dart
class Rectangle {
  final int width;
  final int height;
  final int area;

  const Rectangle({
    required this.width,
    required this.height,
  })  : assert(width > 0),
        assert(height > 0),
        area = width * height;
}
```

## 4. `const` oraz `final`

Dajemy consty wszędzie gdzie się da. Jest to najbardziej powszechny warning ze wszystkich. Flutter bardzo na to patrzy, ponieważ optymalizuje aplikację w taki sposób, żeby nie wołać nigdy drugi raz `build()` na stałych widgetach.

Co do `final`: prawie każdy nasz widget jest `Stateless` a to oznacza, każde w nim pole jest final i nie zmieni się aż nie zostanie zawołany od nowa `build()` *(zmieni się instancja kompletnie)*, więc możecie pisać z automatu to `final` gdzie się da a IDE najwyżej powie jeśli nie może być.

Czasem zdarza się, że nie możecie dać `final` bo wartość nie jest jeszcze znana na początku i poźniej będzie ustawiona. Jeśli i tak nie będzie się po tym przypisaniu zmieniać to możecie użyć `late final`.

## 5. Rozdzielanie importów

Importy rodzielamy na dwa bloki:

1. Importy z zewnętrzych bibliotek
2. Importy z naszego projektu

Wtedy widać lepiej z czego dany widget korzysta. Dodatkowo warto posortować oba bloki żeby importy w nich były w kolejności alfabetycznej *(leksykalnej?)*

Przykład:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bike_buddy/components/drawer/bb_drawer_button.dart';
import 'package:bike_buddy/pages/trip_history.dart';
import 'package:bike_buddy/pages/user_page.dart';
import 'package:bike_buddy/pages/settings/settings_page.dart';
```

Dodatkowo powinniśmy utrzymać konwencję, żeby używać tylko jednego rodzaju ścieżek, czyli albo relatywne albo `package:bike_buddy`. Osobiście jestem za tym drugim, ponieważ na chwilę obecną wszystkie ścieżki są już w tym formacie.

## 6. Nazewnictwo plików/klas/zmiennych

Trzymamy się konwencji z fluttera:

- Pliki: `snake_case`
- Klasy: `PascalCase`
- Zmienne: `camelCase`
- Stałe: `camelCase` ale dodajemy na początek nazwy małe k *(jak konst?)* np. `kNazwaZmiennej`

## 7. Używanie `MaterialStateProperty`

Kiedy chcemy ustawić styl dla przycisku to nie korzystamy z przestarzałego `MaterialStateProperty` tylko `.styleFrom()`:

```dart
//Źle
child: TextButton(
    style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.grey),
        shape:
            MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: const BorderSide(
                        color: Color.fromARGB(
                            255, 111, 111, 111))))),
),

//Dobrze
child: TextButton(
    style: TextButton.styleFrom(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            side: const BorderSide(
                color: Color.fromARGB(255, 111, 111, 111),
            ),
        ),
    ),
),
```

## 8. Korzystanie z `provider`

Żeby korzystać z klasy extendującej `ChangeNotifier` nie trzeba korzystać z klasy `Consumer`. Wystarczy użyć metod `read<T>()` i `watch<T>()`.

```dart
@override
Widget build(BuildContext context) {
    final settings = context.read<SettingsScreenNotifier>();

    return Text(settings.isDarkModeEnabled);
}
```

Różnica między `read()` a `write()` jest taka że write się aktualizuje po zawołaniu `notifyListeners()` a read nie. Teoretycznie jeszcze istnieje `write<T>()` ale nie wiem po co bo jak wczytasz instancję klasy przez read to możesz wołać każdą funkcję z niej normalnie.

## 9. iOS

Pamiętajcie, że nie robimy wersji dla iOS bo nas nie stać na licencję deweloperską. Oznacza to, że spokojnie możemy się pozbyć czegokolwiek związego z `cupertino` w naszym projekcie.
