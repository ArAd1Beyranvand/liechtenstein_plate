import 'dart:math' as math;

import 'package:flutter/widgets.dart' show AssetImage, immutable;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'liechtenstein_colors.dart';
import 'liechtenstein_country.dart';

/// One plate format: the canvas in mm and where its rows sit. The `FL` and
/// arms row is the same on every variant of a format; only the serial row
/// changes, and it is always centred on the plate, so each variant passes the
/// x centres of its own pieces. Positions are read off photographs flattened to
/// mm (`.plateref/li/img`).
///
/// The plates use a condensed face; the fallback is wider. A digit advances
/// 0.5 of the slot height and `spacing` cannot be negative, so a row's height
/// is twice its printed pitch where the plate has room, which gives the right
/// pitch at 65-75% of the reference digit height.
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
  /// `FL` as wide as printed (a dot sits 3 mm right of it on the temporary
  /// plate); the others fill the row's height, wider than printed but clear of
  /// the arms. The box centre is ~2 below the ink centre it should land on.
  final double flCentreY, flGlyph;

  /// The lesser arms where the standard plate of this format prints them.
  final PlateBox arms;

  /// Ink centre of the serial row, the slot height, and the printed pitch.
  final double rowCentreY, rowHeight, pitch;

  /// Where the dot's ink is centred: low in the row on the square plate,
  /// mid-row elsewhere. Includes the 0.65 the dot is otherwise drawn high by.
  final double dotCentreY;

  double get rowTop => rowCentreY - rowHeight / 2;
}

abstract final class _Layout {
  /// 300×80 front plate.
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

  /// 500×110 long rear plate.
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

  /// 300×160 square rear plate. The photographs flatten to an aspect of ~1.75,
  /// not 1.875; the physical size is kept.
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

  /// 180×140 motorcycle plate.
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

  /// 100×140 moped plate, three rows and no arms. The applied insurance
  /// sticker is not drawn.
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

/// The plates since 2019, by format and by mark. Colour is the theme's
/// (`LiechtensteinLivery`): one spec serves every livery.
///
/// - plain: `FL`, arms, digits.
/// - dealer: three digits, a dot and `U`; the arms stay on the top row.
/// - temporary: digits and a raised red bar carrying the expiry month. The
///   front plate has a dot in place of the arms.
/// - customs: three digits, the blank red bar and `Z`.
///
/// Not implemented: pre-2019 series, diplomatic plates, the insurance sticker,
/// and the dealer front plate (no reference).
abstract final class LiechtensteinPlates {
  static final PlateSpec front = _plain('li.front', _Layout.front, 208.75, 43.6);
  static final PlateSpec long = _plain('li.long', _Layout.long, 344, 96.65);
  static final PlateSpec square = _plain('li.square', _Layout.square, 150.25);
  static final PlateSpec motorcycle = _plain('li.motorcycle', _Layout.motorcycle, 86.9);

  static final PlateSpec dealerLong = _dealer(
    'li.dealer.long',
    _Layout.long,
    digits: 303.9,
    dot: 383.75,
    u: 423,
    fl: 106.25,
    arms: const PlateBox(179.5, 29, 29.5, 52),
  );

  static final PlateSpec dealerSquare = _dealer(
    'li.dealer.square',
    _Layout.square,
    digits: 103.4,
    dot: 194.25,
    u: 242.15,
  );

  static final PlateSpec dealerMotorcycle = _dealer(
    'li.dealer.motorcycle',
    _Layout.motorcycle,
    digits: 59.5,
    pitch: 30.8,
    dot: 121.5,
    u: 153.05,
  );

  static final PlateSpec temporaryFront = _temporary(
    'li.temporary.front',
    _Layout.front,
    digits: 167.9,
    bar: const PlateBox(251.5, 12.5, 31.3, 58.5),
    fl: 43.75,
    dot: 80.5,
  );

  static final PlateSpec temporaryLong = _temporary(
    'li.temporary.long',
    _Layout.long,
    digits: 314.5,
    pitch: 45,
    bar: const PlateBox(436, 19.5, 36, 75),
    fl: 71,
    arms: const PlateBox(144, 29, 31.5, 52),
  );

  static final PlateSpec temporarySquare = _temporary(
    'li.temporary.square',
    _Layout.square,
    digits: 130.35,
    pitch: 42.1,
    bar: const PlateBox(237.8, 81, 35.6, 66),
  );

  static final PlateSpec temporaryMotorcycle = _temporary(
    'li.temporary.motorcycle',
    _Layout.motorcycle,
    digits: 69.3,
    pitch: 31.6,
    bar: const PlateBox(136, 72.5, 35, 59.3),
    length: 4,
  );

  static final PlateSpec customsFront = _customs(
    'li.customs.front',
    _Layout.front,
    digits: 160.5,
    bar: const PlateBox(213, 10, 35, 62.5),
    z: 267.75,
    fl: 46.15,
    dot: 95.15,
  );

  static final PlateSpec customsLong = _customs(
    'li.customs.long',
    _Layout.long,
    digits: 299.25,
    bar: const PlateBox(372, 16.8, 37, 75.4),
    z: 435.5,
    fl: 88.5,
    arms: const PlateBox(168.5, 29, 28.5, 52),
  );

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
      _centred('FL', _Layout.mopedFlCentreX, _Layout.mopedFlCentreY, _Layout.mopedFlGlyph),
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

  /// `FL` sits where the standard plate has it, whatever the serial row holds.
  static double _flX(_Format f, double? fl) => fl ?? (identical(f, _Layout.square) ? 114.6 : 52.35);

  static PlateSpec _plain(String id, _Format f, double digits, [double? fl]) => _spec(
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
    labels: <PlateLabel>[_fl(f, fl), _dot(f, dot), _centred('U', u, f.rowCentreY, f.rowHeight)],
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
      // Expiry month: a black square mid-bar, as tall as the bar is wide.
      PlateSlot(
        alphabet: LiechtensteinAlphabets.digits,
        box: PlateBox(bar.left, bar.top + (bar.height - bar.width) / 2, bar.width, bar.width),
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

  static PlateLabel _dot(_Format f, double x) => _centred('•', x, f.dotCentreY, _Layout.dotGlyph);

  /// The raised red bar; its corners are rounded like the plate's, ~2 mm.
  static PlateBand _bar(PlateBox box) => PlateBand(
    box: box,
    color: LiechtensteinColors.temporaryRed,
    topCornerRadius: 2,
    bottomCornerRadius: 2,
  );

  static PlateSlot _row(_Format f, double centreX, int length, {int? minLength, double? pitch}) =>
      _digits(centreX, f.rowTop, f.rowHeight, pitch ?? f.pitch, length, minLength: minLength);

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

  /// A label centred on ([x], [y]). Text is laid out at the box's width, so
  /// the box is sized to the text (`FL` ~0.9 of glyph height, a letter ~0.6).
  static PlateLabel _centred(String text, double x, double y, double glyph) {
    final double width = glyph * (text.length > 1 ? 1 : 0.7);
    return PlateLabel(
      text: text,
      box: PlateBox(x - width / 2, y - glyph / 2, width, glyph),
      glyphHeight: glyph,
    );
  }
}
