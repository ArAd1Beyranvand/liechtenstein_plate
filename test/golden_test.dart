import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liechtenstein_plate/liechtenstein_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category, drawn with real bold faces so the ink can be
/// measured against the references (`.plateref/li/meas.py`).
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final FontLoader loader = FontLoader('Roboto');
    for (final String path in const <String>[
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
    ]) {
      final File face = File(path);
      if (!face.existsSync()) continue;
      loader.addFont(face.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  const LiechtensteinLivery std = LiechtensteinLivery.standard;

  /// category id -> (spec, livery, sample value: one space-separated token
  /// per slot)
  final Map<String, (PlateSpec, LiechtensteinLivery, String)>
  cases = <String, (PlateSpec, LiechtensteinLivery, String)>{
    'front': (LiechtensteinPlates.front, std, '12345'),
    'long': (LiechtensteinPlates.long, std, '65100'),
    'square': (LiechtensteinPlates.square, std, '12345'),
    'motorcycle': (LiechtensteinPlates.motorcycle, std, '1234'),
    'short_term': (
      LiechtensteinPlates.long,
      LiechtensteinLivery.shortTerm,
      '50123',
    ),
    'agricultural': (
      LiechtensteinPlates.front,
      LiechtensteinLivery.agricultural,
      '1943',
    ),
    'utility': (LiechtensteinPlates.square, LiechtensteinLivery.utility, '345'),
    'exceptional': (
      LiechtensteinPlates.long,
      LiechtensteinLivery.exceptional,
      '5012',
    ),
    'repeater': (
      LiechtensteinPlates.long,
      LiechtensteinLivery.repeater,
      '23456',
    ),
    'light_motorcycle': (
      LiechtensteinPlates.motorcycle,
      LiechtensteinLivery.lightMotorcycle,
      '7123',
    ),
    'moped': (LiechtensteinPlates.moped, LiechtensteinLivery.moped, '87 013'),
    'dealer_long': (LiechtensteinPlates.dealerLong, std, '101'),
    'dealer_square': (LiechtensteinPlates.dealerSquare, std, '102'),
    'dealer_motorcycle': (LiechtensteinPlates.dealerMotorcycle, std, '507'),
    'temporary_front': (LiechtensteinPlates.temporaryFront, std, '92999 12'),
    'temporary_long': (LiechtensteinPlates.temporaryLong, std, '92999 12'),
    'temporary_square': (LiechtensteinPlates.temporarySquare, std, '95008 6'),
    'temporary_motorcycle': (
      LiechtensteinPlates.temporaryMotorcycle,
      std,
      '1843 9',
    ),
    'customs_front': (LiechtensteinPlates.customsFront, std, '612'),
    'customs_long': (LiechtensteinPlates.customsLong, std, '612'),
    'customs_square': (LiechtensteinPlates.customsSquare, std, '655'),
  };

  for (final MapEntry<String, (PlateSpec, LiechtensteinLivery, String)> c
      in cases.entries) {
    testWidgets(c.key, (tester) async {
      final (PlateSpec spec, LiechtensteinLivery livery, String values) =
          c.value;
      final PlateTheme theme = LiechtensteinThemes.of(livery, spec);
      final PlateController controller = PlateController.fromValues(
        spec,
        values.split(' '),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 680,
                height: 300,
                child: PlateThemeScope(
                  theme: theme,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: spec.canvasWidth / spec.canvasHeight,
                      child: PlateView(
                        controller: controller,
                        theme: theme,
                        country: LiechtensteinCountry.liechtenstein,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      // The arms are an asset: decode it outside the fake clock.
      await tester.runAsync(() async {
        for (final Element e in find.byType(Image).evaluate()) {
          await precacheImage((e.widget as Image).image, e);
        }
      });
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PlateView),
        matchesGoldenFile('goldens/li_${c.key}.png'),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }
}
