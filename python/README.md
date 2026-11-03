FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the steadfast people of Liechtenstein to view examples:

https://platexample.ir/#/discover/liechtenstein:python

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

### Install (Python)

Copy `python/plates/countries/liechtenstein/` into `plate_core/python/plates/countries/`.

Then run the tests from `plate_core/python/`: `pytest`.

### Use

```python
from plates.countries.liechtenstein.data import SPECS, THEMES

spec = SPECS["li.front"]
theme = THEMES["theme"]
print(spec.id)
```

## Specs

The specs are the same in every language (they come from shared data).

- `li.front`
- `li.long`
- `li.square`
- `li.motorcycle`
- `li.dealer.long`
- `li.dealer.square`
- `li.dealer.motorcycle`
- `li.temporary.front`
- `li.temporary.long`
- `li.temporary.square`
- `li.temporary.motorcycle`
- `li.customs.front`
- `li.customs.long`
- `li.customs.square`
- `li.moped`

## Themes

- `theme`
- `theme~2`
- `theme~3`
- `theme~4`
- `theme~5`
- `theme~6`
- `theme~7`
- `theme~8`
- `theme~9`
- `theme~10`
- `theme~11`

## Change it

- Pick a spec: use another key of `SPECS`.
- Pick a theme: use another key of `THEMES`.
- Validators: `VALIDATORS` maps the names `LiechtensteinValidator` to classes.

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/liechtenstein_plate/blob/main/LICENSE).
