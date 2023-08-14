import 'dart:math' as math;

import 'package:angle_utils/angle_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Creating and converting angle', () {
    var angle0 = Angle.degrees(0);
    var angle90 = Angle.radians(math.pi / 2);
    var angle180 = Angle.degrees(180);
    var angle270 = Angle.gradians(300);
    var angle360 = Angle.turns(1);

    test('.degrees(0) should equal 0 radians, 0 gradians and 0 turns', () {
      expect(angle0.radians, 0);
      expect(angle0.gradians, 0);
      expect(angle0.turns, 0);
    });

    test('.radians(pi/2) should equal 90 degrees, 100 gradians and 0.25 turns', () {
      expect(angle90.degrees, 90.0);
      expect(angle90.gradians, 100);
      expect(angle90.turns, 0.25);
    });

    test('.degrees(180) should equal pi radians, 200 gradians and 0.5 turns', () {
      expect(angle180.radians, math.pi);
      expect(angle180.gradians, 200);
      expect(angle180.turns, 0.5);
    });

    test('.gradians(300) should equal 3*pi/2 radians, 270 degrees and 0.75 turns', () {
      expect(angle270.radians, 3 * math.pi / 2);
      expect(angle270.degrees, 270);
      expect(angle270.turns, 0.75);
    });

    test('.turns(1) should equal 2*pi radians, 400 gradians and 360 degrees', () {
      expect(angle360.radians, 2 * math.pi);
      expect(angle360.gradians, 400);
      expect(angle360.degrees, 360);
    });
  });

  test('.normalized', () {
    expect(Angle.a0().normalized, Angle.a0());
    expect(Angle.a90().normalized, Angle.a90());
    expect(Angle.degrees(450).normalized, Angle.a90());
    expect(Angle.degrees(720).normalized, Angle.a0());
    expect(Angle.degrees(-10).normalized, Angle.degrees(350));
    expect(Angle.degrees(-380).normalized, Angle.degrees(340));
  });

  test('.complementary', () {
    expect(Angle.a0().complementary, Angle.a90());
    expect(Angle.degrees(10).complementary, Angle.degrees(80));
    expect(Angle.degrees(80).complementary, Angle.degrees(10));
    expect(Angle.degrees(25.4).complementary, Angle.degrees(64.6));
    expect(Angle.degrees(100).complementary, Angle.degrees(-10));
  });

  test('.supplementary', () {
    expect(Angle.a0().supplementary, Angle.a180());
    expect(Angle.degrees(80).supplementary, Angle.degrees(100));
    expect(Angle.degrees(170).supplementary, Angle.degrees(10));
    expect(Angle.degrees(90.5).supplementary, Angle.degrees(89.5));
    expect(Angle.degrees(200).supplementary, Angle.degrees(-20));
  });

  test('.distance', () {
    expect(Angle.getMinimalDistance(Angle.a0(), Angle.a90()), Angle.a90());
    expect(Angle.getMinimalDistance(Angle.degrees(45), Angle.degrees(75)), Angle.degrees(30));
    expect(Angle.getMinimalDistance(Angle.degrees(270), Angle.degrees(180)), Angle.a90());
    expect(Angle.getMinimalDistance(Angle.degrees(350), Angle.degrees(10)), Angle.degrees(20));
    expect(Angle.getMinimalDistance(Angle.degrees(-90), Angle.degrees(45)), Angle.degrees(135));
  });

  test('.abs', () {
    expect(Angle.a90().abs(), Angle.a90());
    expect(Angle.degrees(-50).abs(), Angle.degrees(50));
  });

  test('adding angles', () {
    expect(Angle.a90() + Angle.a90(), Angle.a180());
    expect(Angle.degrees(350) + Angle.degrees(20), Angle.degrees(370));
    expect(Angle.degrees(-30) + Angle.degrees(10), Angle.degrees(-20));
    expect(Angle.degrees(-30) + Angle.degrees(-20), Angle.degrees(-50));
  });

  test('substracting angles', () {
    expect(Angle.a90() - Angle.a90(), Angle.a0());
    expect(Angle.a180() - Angle.degrees(45), Angle.degrees(135));
    expect(Angle.degrees(10) - Angle.degrees(45), Angle.degrees(-35));
    expect(Angle.degrees(-30) - Angle.degrees(20), Angle.degrees(-50));
  });

  test('multiplying angles', () {
    expect(Angle.a90() * 3, Angle.a270());
    expect(Angle.degrees(10) * 5, Angle.degrees(50));
    expect(Angle.degrees(-30) * 4, Angle.degrees(-120));
    expect(Angle.degrees(-10) * -5, Angle.degrees(50));
  });

  test('dividing angles', () {
    expect(Angle.a90() / 2, Angle.degrees(45));
    expect(Angle.a0() / 2, Angle.a0());
    expect(Angle.degrees(-10) / 5, Angle.degrees(-2));
    expect(Angle.degrees(-50) / -2, Angle.degrees(25));
  });
}
