import 'dart:math' as math;

import 'package:flutter/widgets.dart' show AssetImage, immutable;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'liechtenstein_colors.dart';
import 'liechtenstein_country.dart';

/// One plate format: the canvas in mm (the sizes the article gives), and where
/// its rows sit. The `FL` and arms row is the same on every variant of a
/// format; only the serial row changes, and it is always centred on the plate,
/// so each variant passes the measured x centres of its own pieces.
///
/// Every reference is a photograph (`.plateref/li/img`), flattened to the
/// format's mm at 4 px per mm (`flat_*`) and read off with `meas.py`.
///
/// The plates use a condensed face; DejaVu Bold is wider. A digit advances
/// 0.5 of the slot height and `spacing` cannot be negative, so a row's height
/// is twice its printed pitch (where the plate has room for that) and the
/// pitch comes out right. A digit's ink is then ~0.43 of the height wide, the
/// measured width, and ~0.525 tall: 65–70% of the reference's height. The
/// per-format notes say how much.
@immutable
class _Format {
  const _Format({
    required this.width,
    required this.height,
    required this.flCentreY,
    required this.flGlyph,
    required this.arms,
    required this.rowCentreY,
    required this.rowHeight,
    required this.pitch,
    required this.dotCentreY,
  });

  final double width, height;

  /// Centre of `FL`'s box and its glyph height. The front plate's glyph makes
  /// `FL` as wide as the printed one (it has a dot 3 mm to its right on the
  /// temporary plate); the others fill the height the row allows, wider than
  /// printed but clear of the arms. The box centre is ~2 below the measured ink
  /// centre, where the golden puts the ink back on it.
  final double flCentreY, flGlyph;

  /// The lesser arms where the standard plate of this format prints them.
  final PlateBox arms;

  /// Ink centre of the serial row, the slot height, and the printed pitch.
  final double rowCentreY, rowHeight, pitch;

  /// Where the dot's ink is centred: low in the row on the square plate
  /// (y 110–121 against digits 76–143), mid-row elsewhere. Each is the
  /// measured centre plus the 0.65 the golden draws the dot high by.
  final double dotCentreY;

  double get rowTop => rowCentreY - rowHeight / 2;
}

abstract final class _Layout {
  /// 300×80 front plate. Measured: `FL` x 14.2–73 y 14.8–65.8; arms x 88–116
  /// y 15–64.5; `12345` x 131–286.5 (pitch 32.1, glyph 27 wide, ink 51 tall).
  /// Golden: digit ink 35.5 tall (70%), `FL` x 14–73.
  static const _Format front = _Format(
    width: 300,
    height: 80,
    flCentreY: 41,
    flGlyph: 68,
    arms: PlateBox(88, 15, 28, 49.5),
    rowCentreY: 40.3,
    rowHeight: 64.2,
    pitch: 32.1,
    dotCentreY: 40.7,
  );

  /// 500×110 long rear plate (`…trailer_plate_current_series`, 65100).
  /// Measured: `FL` x 54.8–138.5 y 21–89.6; arms x 170–201 y 29–81; digits
  /// x 232.5–455.5 (pitch 46, ink 69 tall). Golden:
  /// digit ink 51.8 (75%), `FL` x 50–146.5 y 25–84.
  static const _Format long = _Format(
    width: 500,
    height: 110,
    flCentreY: 55.3,
    flGlyph: 110,
    arms: PlateBox(170, 29, 31, 52),
    rowCentreY: 55.3,
    rowHeight: 92,
    pitch: 46,
    dotCentreY: 55.6,
  );

  /// 300×160 square rear plate. Measured: `FL` x 80.6–148.6 y 13.6–62.2;
  /// arms x 186.5–215.5 y 18–63; digits x 42–258.5 y 76–143 (pitch 44.7). The
  /// photographs flatten to an aspect of ~1.75, not the 1.875 of 300×160; the
  /// physical size is kept. Golden: digit ink 49 (73%), `FL` 41 (84%).
  static const _Format square = _Format(
    width: 300,
    height: 160,
    flCentreY: 40,
    flGlyph: 76,
    arms: PlateBox(186.5, 18, 29, 45),
    rowCentreY: 109.5,
    rowHeight: 89.4,
    pitch: 44.7,
    dotCentreY: 116.1,
  );

  /// 180×140 motorcycle plate. Measured: `FL` x 23.2–81.5 y 9–60; arms
  /// x 125–154 y 12–59; `1234` x 24.8–149 y 76–128 (pitch 32.5). Golden: digit
  /// ink 35 (67%), `FL` 37 (72%).
  static const _Format motorcycle = _Format(
    width: 180,
    height: 140,
    flCentreY: 36.4,
    flGlyph: 69,
    arms: PlateBox(125, 12, 29, 47),
    rowCentreY: 102,
    rowHeight: 65,
    pitch: 32.5,
    dotCentreY: 103.4,
  );

  /// 100×140 moped plate, three rows and no arms: `FL` x ~10–40 y 9.8–31;
  /// `87` x 24–77 y 46–81; `013` x 8–91 y 96.8–131 (pitch 31.5). The insurance
  /// sticker in the top right is applied, not printed, and is not drawn.
  static const double mopedWidth = 100, mopedHeight = 140;
  static const double mopedFlCentreX = 25, mopedFlCentreY = 20.4;
  static const double mopedFlGlyph = 40;
  static const double mopedHighCentreX = 50.5, mopedHighCentreY = 63.5;
  static const double mopedHighHeight = 62, mopedHighPitch = 31;
  static const double mopedLowCentreX = 49.5, mopedLowCentreY = 114;
  static const double mopedLowHeight = 52, mopedLowPitch = 31.5;

  /// A digit is ~0.5 of the slot height in advance; `spacing` brings it to the
  /// printed pitch.
  static const double advance = 0.5;

  /// The `•` that stands in for the arms on dealer plates and the front
  /// temporary and customs plates; its ink is ~10 mm across.
  static const double dotGlyph = 44;
}

/// The Liechtenstein plates since 2019 (black, with `FL`, the lesser arms and up
/// to five digits), by format and by mark. Colour is the theme's: the same
/// spec carries the standard, short-term, agricultural, utility, exceptional
/// and repeater liveries (`LiechtensteinLivery`).
///
/// - plain: `FL`, arms, digits.
/// - dealer: three digits, a dot and `U`; the dot replaces nothing, the arms
///   stay on the top row.
/// - temporary: digits and a raised red bar on the right carrying the expiry
///   month in black. The front plate has a dot in place of the arms.
/// - customs: three digits, the red bar (blank) and `Z`.
///
/// Not implemented: the 1920s–2018 series (history), the CC/CD diplomatic
/// plates (withdrawn; the article has no current picture), and the insurance
/// sticker and its year print. The dealer front plate is not drawn: no
/// reference shows one.
abstract final class LiechtensteinPlates {
  static final PlateSpec front = _plain(
    'li.front',
    _Layout.front,
    208.75,
    43.6,
  );
  static final PlateSpec long = _plain('li.long', _Layout.long, 344, 96.65);
  static final PlateSpec square = _plain('li.square', _Layout.square, 150.25);
  static final PlateSpec motorcycle = _plain(
    'li.motorcycle',
    _Layout.motorcycle,
    86.9,
  );

  /// Measured, `101·U`: `FL` x 65–147.5; arms x 179.5–209; digits
  /// x 243–364.8; dot x 378.5–389 y 49–61; `U` x 405–441.
  static final PlateSpec dealerLong = _dealer(
    'li.dealer.long',
    _Layout.long,
    digits: 303.9,
    dot: 383.75,
    u: 423,
    fl: 106.25,
    arms: const PlateBox(179.5, 29, 29.5, 52),
  );

  /// Measured, `102·U`: digits x 42.8–164; dot x 188–200.5 y 110–121; `U`
  /// x 223.8–260.5.
  static final PlateSpec dealerSquare = _dealer(
    'li.dealer.square',
    _Layout.square,
    digits: 103.4,
    dot: 194.25,
    u: 242.15,
  );

  /// Measured, `507·U`: digits x 15.6–103.4 (pitch 30.8); dot x 117–126
  /// y 98.5–107; `U` x 139.6–166.5.
  static final PlateSpec dealerMotorcycle = _dealer(
    'li.dealer.motorcycle',
    _Layout.motorcycle,
    digits: 59.5,
    pitch: 30.8,
    dot: 121.5,
    u: 153.05,
  );

  /// Measured, `92999`: `FL` x 15–72.5; dot x 76–85 y 34–44; digits
  /// x 90.8–245; bar x 251.5–282.8 y 12.5–71. The article gives the bar as
  /// 33×67; the photograph's 31.3×58.5 is used.
  static final PlateSpec temporaryFront = _temporary(
    'li.temporary.front',
    _Layout.front,
    digits: 167.9,
    bar: const PlateBox(251.5, 12.5, 31.3, 58.5),
    fl: 43.75,
    dot: 80.5,
  );

  /// Measured: `FL` x 28.8–113.2; arms x 144–175.5; digits x 206–423
  /// (pitch 45); bar x 436–472 y 19.5–94.5, the 36×75 the article gives.
  static final PlateSpec temporaryLong = _temporary(
    'li.temporary.long',
    _Layout.long,
    digits: 314.5,
    pitch: 45,
    bar: const PlateBox(436, 19.5, 36, 75),
    fl: 71,
    arms: const PlateBox(144, 29, 31.5, 52),
  );

  /// Measured, `95008`: digits x 28.9–231.8 (pitch 42.1); bar x 237.8–273.4.
  static final PlateSpec temporarySquare = _temporary(
    'li.temporary.square',
    _Layout.square,
    digits: 130.35,
    pitch: 42.1,
    bar: const PlateBox(237.8, 81, 35.6, 66),
  );

  /// Measured, `1843`: digits x 8.8–129.8 (pitch 31.6); bar x 136–171
  /// y 72.5–131.8.
  static final PlateSpec temporaryMotorcycle = _temporary(
    'li.temporary.motorcycle',
    _Layout.motorcycle,
    digits: 69.3,
    pitch: 31.6,
    bar: const PlateBox(136, 72.5, 35, 59.3),
    length: 4,
  );

  /// Measured, `612 Z`: `FL` x 15.8–76.5; dot x 90.8–99.5 y 36.8–45.5; digits
  /// x 114–207; bar x 213–248 y 10–72.5; `Z` x 253.5–282.
  static final PlateSpec customsFront = _customs(
    'li.customs.front',
    _Layout.front,
    digits: 160.5,
    bar: const PlateBox(213, 10, 35, 62.5),
    z: 267.75,
    fl: 46.15,
    dot: 95.15,
  );

  /// Measured, `612 Z`: `FL` x 46.5–130.5; arms x 168.5–197; digits
  /// x 235–363.5; bar x 372–409 y 16.8–92.2; `Z` x 417–454.
  static final PlateSpec customsLong = _customs(
    'li.customs.long',
    _Layout.long,
    digits: 299.25,
    bar: const PlateBox(372, 16.8, 37, 75.4),
    z: 435.5,
    fl: 88.5,
    arms: const PlateBox(168.5, 29, 28.5, 52),
  );

  /// Measured, `655 Z`: digits x 44.8–164 (pitch 42.5); bar x 175.8–210.5
  /// y 81–147; `Z` x 220–252.
  static final PlateSpec customsSquare = _customs(
    'li.customs.square',
    _Layout.square,
    digits: 104.4,
    pitch: 42.5,
    bar: const PlateBox(175.8, 81, 34.7, 66),
    z: 236,
  );

  /// Mopeds and e-bikes, 80000–89999 split `87` over `013`.
  static final PlateSpec moped = PlateSpec(
    id: 'li.moped',
    country: LiechtensteinCountry.liechtenstein,
    canvasWidth: _Layout.mopedWidth,
    canvasHeight: _Layout.mopedHeight,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.mopedHeight)),
    slots: <PlateSlot>[
      _digits(
        _Layout.mopedHighCentreX,
        _Layout.mopedHighCentreY - _Layout.mopedHighHeight / 2,
        _Layout.mopedHighHeight,
        _Layout.mopedHighPitch,
        2,
      ),
      _digits(
        _Layout.mopedLowCentreX,
        _Layout.mopedLowCentreY - _Layout.mopedLowHeight / 2,
        _Layout.mopedLowHeight,
        _Layout.mopedLowPitch,
        3,
      ),
    ],
    labels: <PlateLabel>[
      _centred(
        'FL',
        _Layout.mopedFlCentreX,
        _Layout.mopedFlCentreY,
        _Layout.mopedFlGlyph,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1], key: 'serial'),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    front,
    long,
    square,
    motorcycle,
    moped,
    dealerLong,
    dealerSquare,
    dealerMotorcycle,
    temporaryFront,
    temporaryLong,
    temporarySquare,
    temporaryMotorcycle,
    customsFront,
    customsLong,
    customsSquare,
  ];

  static PlateSpec _spec(
    String id,
    _Format f, {
    required List<PlateSlot> slots,
    required List<PlateLabel> labels,
    PlateBox? arms,
    List<PlateBand> bands = const <PlateBand>[],
    bool withMonth = false,
  }) => PlateSpec(
    id: id,
    country: LiechtensteinCountry.liechtenstein,
    canvasWidth: f.width,
    canvasHeight: f.height,
    noPanel: true,
    panel: PlatePanel(box: PlateBox(0, 0, 0, f.height)),
    bands: bands,
    slots: slots,
    labels: labels,
    decals: <PlateDecal>[
      if (arms != null)
        PlateDecal(
          // Commons: File:Lesser_Coat_of_arms_of_Liechtenstein.svg.
          image: const AssetImage(
            'assets/icons/liechtenstein_lesser_arms.png',
            package: 'liechtenstein_plate',
          ),
          box: arms,
        ),
    ],
    textGroups: <PlateTextGroup>[
      const PlateTextGroup(<int>[0], key: 'serial'),
      if (withMonth) PlateTextGroup(<int>[slots.length - 1], key: 'month'),
    ],
  );

  /// `FL` on the two-line plates sits where the standard plate has it,
  /// whatever the serial row holds: x 80.6–148.6 of 300, 23.2–81.5 of 180.
  static double _flX(_Format f, double? fl) =>
      fl ?? (identical(f, _Layout.square) ? 114.6 : 52.35);

  static PlateSpec _plain(String id, _Format f, double digits, [double? fl]) =>
      _spec(
        id,
        f,
        slots: <PlateSlot>[_row(f, digits, 5, minLength: 1)],
        labels: <PlateLabel>[_fl(f, fl)],
        arms: f.arms,
      );

  static PlateSpec _dealer(
    String id,
    _Format f, {
    required double digits,
    required double dot,
    required double u,
    double? fl,
    PlateBox? arms,
    double? pitch,
  }) => _spec(
    id,
    f,
    slots: <PlateSlot>[_row(f, digits, 3, pitch: pitch)],
    labels: <PlateLabel>[
      _fl(f, fl),
      _dot(f, dot),
      _centred('U', u, f.rowCentreY, f.rowHeight),
    ],
    arms: arms ?? f.arms,
  );

  /// [dot] set means a front plate: the dot takes the arms' place.
  static PlateSpec _temporary(
    String id,
    _Format f, {
    required double digits,
    required PlateBox bar,
    double? fl,
    double? dot,
    PlateBox? arms,
    int length = 5,
    double? pitch,
  }) => _spec(
    id,
    f,
    bands: <PlateBand>[_bar(bar)],
    slots: <PlateSlot>[
      _row(f, digits, length, minLength: 4, pitch: pitch),
      // The expiry month, black, in a square at the middle of the bar: the
      // photographs print it about as tall as the bar is wide.
      PlateSlot(
        alphabet: LiechtensteinAlphabets.digits,
        box: PlateBox(
          bar.left,
          bar.top + (bar.height - bar.width) / 2,
          bar.width,
          bar.width,
        ),
        length: 2,
        minLength: 1,
        color: LiechtensteinColors.black,
      ),
    ],
    labels: <PlateLabel>[_fl(f, fl), if (dot != null) _dot(f, dot)],
    arms: dot != null ? null : arms ?? f.arms,
    withMonth: true,
  );

  static PlateSpec _customs(
    String id,
    _Format f, {
    required double digits,
    required PlateBox bar,
    required double z,
    double? fl,
    double? dot,
    PlateBox? arms,
    double? pitch,
  }) => _spec(
    id,
    f,
    bands: <PlateBand>[_bar(bar)],
    slots: <PlateSlot>[_row(f, digits, 3, pitch: pitch)],
    labels: <PlateLabel>[
      _fl(f, fl),
      if (dot != null) _dot(f, dot),
      _centred('Z', z, f.rowCentreY, f.rowHeight),
    ],
    arms: dot != null ? null : arms ?? f.arms,
  );

  static PlateLabel _fl(_Format f, double? fl) =>
      _centred('FL', _flX(f, fl), f.flCentreY, f.flGlyph);

  static PlateLabel _dot(_Format f, double x) =>
      _centred('•', x, f.dotCentreY, _Layout.dotGlyph);

  /// The raised red bar; its corners are rounded like the plate's, ~2 mm.
  static PlateBand _bar(PlateBox box) => PlateBand(
    box: box,
    color: LiechtensteinColors.temporaryRed,
    topCornerRadius: 2,
    bottomCornerRadius: 2,
  );

  static PlateSlot _row(
    _Format f,
    double centreX,
    int length, {
    int? minLength,
    double? pitch,
  }) => _digits(
    centreX,
    f.rowTop,
    f.rowHeight,
    pitch ?? f.pitch,
    length,
    minLength: minLength,
  );

  static PlateSlot _digits(
    double centreX,
    double top,
    double height,
    double pitch,
    int length, {
    int? minLength,
  }) {
    final double width = length * pitch + 4;
    return PlateSlot(
      alphabet: LiechtensteinAlphabets.digits,
      box: PlateBox(centreX - width / 2, top, width, height),
      length: length,
      minLength: minLength,
      // A pitch tighter than the font's advance scales the run down instead.
      spacing: math.max(0, pitch - _Layout.advance * height),
    );
  }

  /// A label centred on ([x], [y]). A label is centred in its box, but its
  /// text is laid out at the box's width, so the box is as wide as the text:
  /// `FL` is ~0.9 of its glyph height across, a letter ~0.6.
  static PlateLabel _centred(String text, double x, double y, double glyph) {
    final double width = glyph * (text.length > 1 ? 1 : 0.7);
    return PlateLabel(
      text: text,
      box: PlateBox(x - width / 2, y - glyph / 2, width, glyph),
      glyphHeight: glyph,
    );
  }
}
