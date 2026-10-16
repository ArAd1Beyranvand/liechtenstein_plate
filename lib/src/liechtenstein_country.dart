import 'package:plate_core/plate_core.dart';

import 'liechtenstein_colors.dart';

/// The plates have no country block: `FL` is a label and the lesser arms a
/// decal on each spec, so the panel is unused.
abstract final class LiechtensteinCountry {
  static const PlateCountry liechtenstein = PlateCountry(
    code: 'li',
    captionLines: <String>[],
    panelColor: LiechtensteinColors.black,
    panelTextColor: LiechtensteinColors.white,
  );
}
