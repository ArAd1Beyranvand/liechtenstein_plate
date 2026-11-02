import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'liechtenstein_colors.dart';

/// A plate colourway: an ink on a field. It follows the vehicle's category,
/// not the plate's shape.
@immutable
class LiechtensteinLivery {
  const LiechtensteinLivery(this.field, this.ink);

  final Color field;
  final Color ink;

  static const LiechtensteinLivery standard = LiechtensteinLivery(
    LiechtensteinColors.black,
    LiechtensteinColors.white,
  );

  /// Short-term plates, valid up to four days.
  static const LiechtensteinLivery shortTerm = LiechtensteinLivery(
    LiechtensteinColors.black,
    LiechtensteinColors.shortTermYellow,
  );

  static const LiechtensteinLivery agricultural = LiechtensteinLivery(
    LiechtensteinColors.agriculturalGreen,
    LiechtensteinColors.black,
  );

  static const LiechtensteinLivery utility = LiechtensteinLivery(
    LiechtensteinColors.utilityBlue,
    LiechtensteinColors.black,
  );

  static const LiechtensteinLivery exceptional = LiechtensteinLivery(
    LiechtensteinColors.exceptionalOchre,
    LiechtensteinColors.black,
  );

  /// The red third plate for a rear load carrier.
  static const LiechtensteinLivery repeater = LiechtensteinLivery(
    LiechtensteinColors.repeaterRed,
    LiechtensteinColors.white,
  );

  static const LiechtensteinLivery lightMotorcycle = LiechtensteinLivery(
    LiechtensteinColors.lightMotorcycleYellow,
    LiechtensteinColors.black,
  );

  static const LiechtensteinLivery moped = LiechtensteinLivery(
    LiechtensteinColors.mopedAmber,
    LiechtensteinColors.black,
  );
}

/// Every format has a 10 mm corner radius and a ~1 mm rim, so both ratios
/// depend on the plate's height: pass the spec the theme is for.
abstract final class LiechtensteinThemes {
  static PlateTheme of(LiechtensteinLivery livery, PlateSpec spec) =>
      PlateTheme.monochrome(
        field: livery.field,
        ink: livery.ink,
        inactive: LiechtensteinColors.inactive,
        borderWidthRatio: 1 / spec.canvasHeight,
        plateRadiusRatio: 10 / spec.canvasHeight,
      );
}
