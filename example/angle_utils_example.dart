import 'package:angle_utils/angle_utils.dart';

void main() {
  var angle = Angle.degrees(90);
  angle.radians; // pi/2
  angle.degrees; // 90
  angle.gradians; // 100
  angle.turns; // 1/4

  var full = Angle.full();
  full.radians; // 2*pi
  full.degrees; // 360
  full.gradians; // 400
  full.turns; // 1

  var diff = full - angle;
  diff.degrees; // 270

  var other = Angle.degrees(-10);
  other.normalized.degrees; // 350

  var range = AngleRange(start: Angle.degrees(80), end: Angle.degrees(100));
  range.start; // Angle.degrees(80)
  range.end; // Angle.degrees(100)
  range.mid; // Angle.degrees(90)
  range.sweep; // Angle.degrees(20)

  range.includes(Angle.degrees(90)); // true
}
