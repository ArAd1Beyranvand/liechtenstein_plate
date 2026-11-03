import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';
import 'package:liechtenstein_plate/liechtenstein_plate.dart';

void main() => runApp(
  PlateExampleApp(
    spec: LiechtensteinPlates.front,
    theme: LiechtensteinThemes.of(
      LiechtensteinLivery.standard,
      LiechtensteinPlates.front,
    ),
  ),
);
