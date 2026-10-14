import 'package:plate_core/plate_core.dart';

/// The number ranges of one Liechtenstein category, as the article lists them.
/// Reports, never bars a keystroke.
///
/// The serial is digits only; a dealer number takes `U` and a customs number
/// `Z`, printed by the spec, so neither is typed.
class LiechtensteinValidator extends GatedPlateValidator {
  const LiechtensteinValidator(this.ranges, this.reason);

  /// Inclusive ranges the serial must fall in.
  final List<(int, int)> ranges;
  final String reason;

  @override
  String get gateGroup => 'serial';

  /// Cars and other standard vehicles: 1–20 are official, 2000–50000 general.
  static const LiechtensteinValidator standard = LiechtensteinValidator(
    <(int, int)>[(1, 20), (2000, 50000)],
    'A standard number is 1–20 (official) or 2000–50000.',
  );

  static const LiechtensteinValidator trailer = LiechtensteinValidator(
    <(int, int)>[(65100, 70000)],
    'A trailer number is 65100–70000.',
  );

  static const LiechtensteinValidator shortTerm = LiechtensteinValidator(
    <(int, int)>[(50000, 50299)],
    'A short-term number is 50000–50299.',
  );

  /// Agricultural, utility and exceptional plates share 21–2000; exceptional
  /// trailers run from 5000.
  static const LiechtensteinValidator special = LiechtensteinValidator(
    <(int, int)>[(21, 2000), (5000, 9999)],
    'A special-vehicle number is 21–2000, or from 5000 for a trailer.',
  );

  static const LiechtensteinValidator lightMotorcycle = LiechtensteinValidator(
    <(int, int)>[(7000, 7999)],
    'A light motorcycle number is 7000–7999.',
  );

  static const LiechtensteinValidator moped = LiechtensteinValidator(
    <(int, int)>[(80000, 89999)],
    'A moped number is 80000–89999.',
  );

  static const LiechtensteinValidator dealer = LiechtensteinValidator(
    <(int, int)>[(101, 300)],
    'A dealer number is 101–300.',
  );

  static const LiechtensteinValidator dealerMotorcycle = LiechtensteinValidator(
    <(int, int)>[(501, 999)],
    'A motorcycle dealer number is from 501.',
  );

  static const LiechtensteinValidator temporary = LiechtensteinValidator(
    <(int, int)>[(90000, 92999), (95000, 95099)],
    'A temporary number is 90000–92999 or 95000–95099.',
  );

  static const LiechtensteinValidator temporaryMotorcycle =
      LiechtensteinValidator(<(int, int)>[
        (1801, 1999),
      ], 'A temporary motorcycle number is from 1801.');

  static const LiechtensteinValidator customs = LiechtensteinValidator(
    <(int, int)>[(600, 799)],
    'A customs number is from 600 (cars) or 700.',
  );

  @override
  PlateValidation judge(PlateEntry entry) {
    final String serial = entry.group('serial');
    final int? n = RegExp(r'^[0-9]+$').hasMatch(serial)
        ? int.tryParse(serial)
        : null;
    final bool ok =
        n != null &&
        !serial.startsWith('0') &&
        ranges.any(((int, int) r) => n >= r.$1 && n <= r.$2);
    final String month = entry.group('month');
    final int? m = int.tryParse(month);
    final bool monthOk = month.isEmpty || (m != null && m >= 1 && m <= 12);
    return ok && monthOk
        ? const PlateValidation.valid()
        : PlateValidation.invalid(reason);
  }
}
