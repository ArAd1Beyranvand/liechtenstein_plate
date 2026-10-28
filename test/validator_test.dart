import 'package:flutter_test/flutter_test.dart';
import 'package:liechtenstein_plate/liechtenstein_plate.dart';
import 'package:plate_core/plate_core.dart';

void main() {
  PlateValidation judge(
    LiechtensteinValidator v,
    PlateSpec spec,
    List<String> values,
  ) => v.judge(PlateEntry(spec: spec, values: values));

  test('standard ranges', () {
    final PlateSpec s = LiechtensteinPlates.long;
    const LiechtensteinValidator v = LiechtensteinValidator.standard;
    expect(judge(v, s, <String>['12345']).isValid, true);
    expect(judge(v, s, <String>['7']).isValid, true);
    expect(judge(v, s, <String>['500']).isValid, false);
    expect(judge(v, s, <String>['01234']).isValid, false);
  });

  test('a temporary plate needs a month 1-12', () {
    final PlateSpec s = LiechtensteinPlates.temporaryLong;
    const LiechtensteinValidator v = LiechtensteinValidator.temporary;
    expect(judge(v, s, <String>['92999', '12']).isValid, true);
    expect(judge(v, s, <String>['92999', '13']).isValid, false);
  });

  test('every spec is inside its canvas', () {
    for (final PlateSpec spec in LiechtensteinPlates.all) {
      expect(debugValidateSpec(spec), true, reason: spec.id);
    }
  });
}
