import 'dart:math' as math;

import 'package:angle_utils/angle_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Angle', () {
    var angle0 = Angle.degrees(0);
    var angle90 = Angle.radians(math.pi/2);
    var angle180 = Angle.degrees(180);

    test('.degrees(0) should equal 0 radians', () {
      expect(angle0.radians, 0);
    });

    test('.radians(pi/2) should equal 90 degrees', () {
      expect(angle90.degrees, 90.0);
    });

    test('.degrees(180) should equal pi radians', () {
      expect(angle180.radians, math.pi);
    });
  });
}
