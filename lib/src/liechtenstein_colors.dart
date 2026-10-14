import 'package:flutter/widgets.dart';

/// The colours of the Liechtenstein plates, each the modal pixel of a field or
/// ink region in the article's photographs (`.plateref/li`). Where the article
/// names a colour it is often a different one: its "light brown" is an ochre,
/// its "light green" a mint and its "dark yellow" an amber.
abstract final class LiechtensteinColors {
  /// The standard field (`Liechtenstein_trailer_plate_current_series`); also
  /// the ink on the coloured plates, which samples 13130D–2B241C across six
  /// photographs, i.e. the same black under different light.
  static const Color black = Color(0xFF1C1B1C);

  static const Color white = Color(0xFFFEFEFE);

  /// Short-term ink (`…valid_for_4_days_max`; the other two short-term plates
  /// give FDF414 and F5DB35).
  static const Color shortTermYellow = Color(0xFFFAEB1B);

  /// Agricultural and forestry field (`…agricultural_vehicle_front…FL_1943`).
  static const Color agriculturalGreen = Color(0xFF1AD584);

  /// Utility field: the per-channel median of 6BBCFC, 33B4EB and 53BCF2, three
  /// photographs that disagree only in lighting.
  static const Color utilityBlue = Color(0xFF53BCF2);

  /// Exceptional-vehicle field: median of FBBD5B, EDAC53 and F3AB4C.
  static const Color exceptionalOchre = Color(0xFFF3AC53);

  /// Repeater ("third plate") field (`Wiederholungskennzeichen…`).
  static const Color repeaterRed = Color(0xFFE31D1A);

  /// Light motorcycles and electric vehicles (`FL_7xxx` and `Scooter…`, both
  /// F4E30C).
  static const Color lightMotorcycleYellow = Color(0xFFF4E30C);

  /// Mopeds and e-bikes (`Liechtenstein_moped_plate`, and DBA403 on the 1988
  /// plate).
  static const Color mopedAmber = Color(0xFFDBA402);

  /// The raised bar on temporary and customs plates: median of FD1A25, F3131B
  /// and E3232C.
  static const Color temporaryRed = Color(0xFFF31A25);

  static const Color inactive = Color(0xFF8A8A8A);
}
