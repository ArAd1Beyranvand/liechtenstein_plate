/// Liechtenstein's licence plates for the `plate_core` library.
///
/// The black `FL` plates in five formats, with dealer, temporary and customs
/// variants, eight liveries, and an advisory validator per category.
library;

// TODO(py): [D5] one module `plates.countries.liechtenstein`; assets via importlib.resources.
// TODO(ts): [D5] one subpath export `./countries/liechtenstein`; tree-shakable.
// TODO(kt): [D5] package `countries.liechtenstein` in the countries module.
export 'package:plate_alphabet/plate_alphabet.dart' show LiechtensteinAlphabets;
export 'src/liechtenstein_colors.dart';
export 'src/liechtenstein_country.dart';
export 'src/liechtenstein_plates.dart';
export 'src/liechtenstein_themes.dart';
export 'src/liechtenstein_validators.dart';
