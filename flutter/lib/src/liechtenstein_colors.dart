import 'package:flutter/widgets.dart';

/// Each the modal pixel of a field or ink region in reference photographs
/// (`.plateref/li`); where an article names a colour it is often a different
/// one (its "light brown" is an ochre, its "light green" a mint).
abstract final class LiechtensteinColors {
  /// The standard field, and the ink on the coloured plates.
  static const Color black = Color(0xFF1C1B1C);

  static const Color white = Color(0xFFFEFEFE);

  /// Short-term ink.
  static const Color shortTermYellow = Color(0xFFFAEB1B);

  /// Agricultural and forestry field.
  static const Color agriculturalGreen = Color(0xFF1AD584);

  /// Utility field; the median of three photographs that differ in lighting.
  static const Color utilityBlue = Color(0xFF53BCF2);

  /// Exceptional-vehicle field (median of three photographs).
  static const Color exceptionalOchre = Color(0xFFF3AC53);

  /// Repeater ("third plate") field.
  static const Color repeaterRed = Color(0xFFE31D1A);

  /// Light motorcycles and electric vehicles.
  static const Color lightMotorcycleYellow = Color(0xFFF4E30C);

  /// Mopeds and e-bikes.
  static const Color mopedAmber = Color(0xFFDBA402);

  /// The raised bar on temporary and customs plates (median of three).
  static const Color temporaryRed = Color(0xFFF31A25);

  static const Color inactive = Color(0xFF8A8A8A);
}
