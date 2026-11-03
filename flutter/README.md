FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the steadfast people of Liechtenstein to view examples:

https://platexample.ir/#/discover/liechtenstein:flutter

# liechtenstein_plate

Liechtenstein's licence plates for plate_core: FL, the lesser arms and up to five digits in the front, long, square, motorcycle and moped formats, with dealer, and more.

## Languages

| Language | Folder | Example |
| --- | --- | --- |
| Flutter / Dart | [`flutter/`](https://github.com/ArAd1Beyranvand/liechtenstein_plate/tree/main/flutter) | [platexample](https://platexample.ir/#/discover/liechtenstein:flutter) |
| Kotlin | [`kotlin/`](https://github.com/ArAd1Beyranvand/liechtenstein_plate/tree/main/kotlin) | [platexample](https://platexample.ir/#/discover/liechtenstein:kotlin) |
| Python | [`python/`](https://github.com/ArAd1Beyranvand/liechtenstein_plate/tree/main/python) | [platexample](https://platexample.ir/#/discover/liechtenstein:python) |
| TypeScript | [`typescript/`](https://github.com/ArAd1Beyranvand/liechtenstein_plate/tree/main/typescript) | [platexample](https://platexample.ir/#/discover/liechtenstein:typescript) |

## Quick start

### Install

```yaml
dependencies:
  plate_core: ^0.12.0
  liechtenstein_plate: ^0.1.0
```

### Use

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

## Specs

Each spec is one plate layout.

- `LiechtensteinPlates.front`
- `LiechtensteinPlates.long`
- `LiechtensteinPlates.square`
- `LiechtensteinPlates.motorcycle`
- `LiechtensteinPlates.dealerLong`
- `LiechtensteinPlates.dealerSquare`
- `LiechtensteinPlates.dealerMotorcycle`
- `LiechtensteinPlates.temporaryFront`
- `LiechtensteinPlates.temporaryLong`
- `LiechtensteinPlates.temporarySquare`
- `LiechtensteinPlates.temporaryMotorcycle`
- `LiechtensteinPlates.customsFront`
- `LiechtensteinPlates.customsLong`
- `LiechtensteinPlates.customsSquare` — id `li.moped`
- `LiechtensteinPlates.moped` — id `li.moped`

## Themes

- `LiechtensteinLivery.of`(…)

## Change it

`PlateCanvas` takes `spec:` (an entry of `LiechtensteinPlates`) and `theme:` (an entry of `LiechtensteinLivery`). Set `validator:` to `LiechtensteinValidator()` and `autoValidate: true` to show validation hints.

## Also included

- `LiechtensteinCountry` — the country panel.
- `LiechtensteinValidator` — the plate validator.

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

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/liechtenstein_plate/blob/main/LICENSE).
