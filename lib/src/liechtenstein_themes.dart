import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'liechtenstein_colors.dart';

/// One of the plate colourways: an ink on a field. Which one a vehicle gets is
/// its category, not its plate's shape, so every livery fits every format the
/// law allows it on.
@immutable
class LiechtensteinLivery {
  const LiechtensteinLivery(this.field, this.ink);

  final Color field;
  final Color ink;

  /// Cars, lorries, buses, trailers and motorcycles.
  static const LiechtensteinLivery standard = LiechtensteinLivery(
    LiechtensteinColors.black,
    LiechtensteinColors.white,
  );

  /// Short-term plates, 50000 to 50299, valid up to four days.
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

/// Themes for the plates. The law gives every format the same 10 mm corner
/// radius, and the raised rim is about 1 mm, so both ratios depend on the
/// plate's height: pass the spec the theme is for.
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
