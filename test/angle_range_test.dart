import 'package:angle_utils/angle_utils.dart';
import 'package:test/test.dart';

void main() {
  var range1 = AngleRange(start: Angle.a0(), end: Angle.a90());
  var range2 = AngleRange(start: Angle.a180(), end: Angle.degrees(280));
  var range3 = AngleRange(start: Angle.a270(), end: Angle.degrees(10));
  var range4 = AngleRange(start: Angle.degrees(-40), end: Angle.degrees(-60));

  test('start and end', () {
    expect(range1.start, Angle.a0());
    expect(range1.end, Angle.a90());

    expect(range2.start, Angle.a180());
    expect(range2.end, Angle.degrees(280));

    expect(range3.start, Angle.a270());
    expect(range3.end, Angle.degrees(10));

    expect(range4.start, Angle.degrees(-40));
    expect(range4.end, Angle.degrees(-60));
  });

  test('sweep', () {
    expect(range1.sweep, Angle.a90());
    expect(range2.sweep, Angle.degrees(100));
    expect(range3.sweep, Angle.degrees(100));
    expect(range4.sweep, Angle.degrees(340));
  });

  test('mid', () {
    expect(range1.mid, Angle.degrees(45));
    expect(range2.mid, Angle.degrees(230));
    expect(range3.mid, Angle.degrees(320));
    expect(range4.mid, Angle.degrees(130));
  });

  test('fromSweep', () {
    var range = AngleRange.fromSweep(Angle.degrees(100), Angle.degrees(50));

    expect(range.start, Angle.degrees(100));
    expect(range.end, Angle.degrees(150));
    expect(range.mid, Angle.degrees(125));
    expect(range.sweep, Angle.degrees(50));
  });

  test('fromDelta', () {
    var range = AngleRange.fromDelta(Angle.degrees(45), Angle.degrees(10));

    expect(range.start, Angle.degrees(35));
    expect(range.end, Angle.degrees(55));
    expect(range.mid, Angle.degrees(45));
    expect(range.sweep, Angle.degrees(20));
  });

  test('normalized', () {
    var range = AngleRange(start: Angle.degrees(-10), end: Angle.degrees(-5))
        .normalized;

    expect(range.start, Angle.degrees(350));
    expect(range.end, Angle.degrees(355));
    expect(range.mid, Angle.degrees(352.5));
    expect(range.sweep, Angle.degrees(5));

    expect(range, AngleRange.normalized(Angle.degrees(-10), Angle.degrees(-5)));
  });

  test('includesNormalized', () {
    var range = AngleRange(start: Angle.degrees(370), end: Angle.degrees(390));

    expect(range.includesNormalized(Angle.degrees(360)), false);
    expect(range.includesNormalized(Angle.degrees(400)), false);
    expect(range.includesNormalized(Angle.degrees(390)), true);
    expect(range.includesNormalized(Angle.degrees(370)), true);
    expect(range.includesNormalized(Angle.degrees(380)), true);
    expect(range.includesNormalized(Angle.degrees(740)), true);
    expect(range.includesNormalized(Angle.degrees(15)), true);
  });

  test('includes', () {
    var range = AngleRange(start: Angle.degrees(370), end: Angle.degrees(390));

    expect(range.includes(Angle.degrees(360)), false);
    expect(range.includes(Angle.degrees(400)), false);
    expect(range.includes(Angle.degrees(390)), true);
    expect(range.includes(Angle.degrees(370)), true);
    expect(range.includes(Angle.degrees(380)), true);
    expect(range.includes(Angle.degrees(740)), false);
    expect(range.includes(Angle.degrees(15)), false);
  });

  test('errors', () {
    expect(() => AngleRange.fromDelta(Angle.degrees(90), Angle.degrees(-10)),
        throwsArgumentError);
    expect(() => AngleRange(start: Angle.degrees(0), end: Angle.degrees(370)),
        throwsArgumentError);
  });
}
