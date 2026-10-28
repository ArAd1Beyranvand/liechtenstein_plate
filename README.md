FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the steadfast people of Liechtenstein to view examples:

https://platexample.ir/#/discover/liechtenstein

# liechtenstein_plate

Liechtenstein's licence plates for the `plate_core` library. The black `FL` plates in five formats, with dealer, temporary and customs variants, eight liveries, and an advisory validator per category.

## Install

```yaml
dependencies:
  plate_core: ^0.12.0
  liechtenstein_plate: ^0.1.0
```

## Use

```dart
import 'package:plate_core/plate_core.dart';
import 'package:liechtenstein_plate/liechtenstein_plate.dart';

PlateCanvas(
  spec: LiechtensteinPlates.front,
  validator: const LiechtensteinValidator(),
  autoValidate: true,
  onChooseCharacter: noCharacterChooser,
);
```

## Contains

- `LiechtensteinCountry` — country panel: `liechtenstein`.
- `LiechtensteinPlates` — 15 plate specs: `front`, `long`, `square`, `motorcycle`, `dealerLong`, `dealerSquare`, `dealerMotorcycle`, `temporaryFront`, `temporaryLong`, `temporarySquare`, `temporaryMotorcycle`, `customsFront`, `customsLong`, `customsSquare` and 1 more.
- `LiechtensteinValidator` — advisory validator; flags the frame, never blocks a keystroke.
- 1 bundled asset (`liechtenstein_lesser_arms.png`).

## Plates

The plates since 2019, by format and by mark. Colour is the theme's
(`LiechtensteinLivery`): one spec serves every livery.

- plain: `FL`, arms, digits.
- dealer: three digits, a dot and `U`; the arms stay on the top row.
- temporary: digits and a raised red bar carrying the expiry month. The
  front plate has a dot in place of the arms.
- customs: three digits, the blank red bar and `Z`.

Not implemented: pre-2019 series, diplomatic plates, the insurance sticker,
and the dealer front plate (no reference).

## Part of plate

Painted by [`plate_core`](https://pub.dev/packages/plate_core); alphabets shared through [`plate_alphabet`](https://pub.dev/packages/plate_alphabet); optional character picker in [`plate_keypad`](https://pub.dev/packages/plate_keypad).

