import 'dart:core';
import 'dart:math' as math;

import 'num_extension.dart';

/// Represents an angle.
/// Internally the angle is stored in radians.
class Angle implements Comparable<Angle> {
  final double _radians;

  bool get isZero => _radians == 0;

  bool get isPositive => _radians >= 0;
  bool get isNegative => _radians < 0;

  /// Returns the normalized angle:
  /// 45° -> 45°
  /// 370° -> 10°
  /// -90° -> 270°
  Angle get normalized {
    var remainder = _radians.remainder(2 * math.pi);
    if (isPositive) {
      return Angle.radians(remainder);
    } else {
      return Angle.full() + Angle.radians(remainder);
    }
  }

  /// Returns the complementary angle of this
  Angle get complementary => Angle.a90() - this;

  /// Returns the supplementary angle of this
  Angle get supplementary => Angle.a180() - this;

  double get radians => _radians;
  double get degrees => Angle.radiansToDegrees(_radians);
  double get turns => Angle.radiansToTurns(_radians);
  double get gradians => Angle.radiansToGradians(_radians);

  Angle._({required double radians}) : _radians = radians;

  /// Constructs an angle from degrees
  Angle.degrees(final double degrees)
      : _radians = Angle.degreesToRadians(degrees);

  /// Constructs an angle from turns
  Angle.turns(final double turns) : _radians = Angle.turnsToRadians(turns);

  /// Constructs an angle from gradians
  Angle.gradians(final double gradians)
      : _radians = Angle.gradiansToRadians(gradians);

  /// Constructs an angle from radians
  Angle.radians(final double radians) : _radians = radians;

  Angle.atan2(num a, num b) : _radians = math.atan2(a, b);

  /// Constructs an angle with 0 degrees
  factory Angle.zero() => Angle._(radians: 0);

  /// Constructs an angle with 180 degrees
  factory Angle.half() => Angle._(radians: math.pi);

  /// Constructs an angle with 360 degrees
  factory Angle.full() => Angle._(radians: 2 * math.pi);

  /// Constructs an angle with 0 degrees
  factory Angle.a0() => Angle.zero();

  /// Constructs an angle with 90 degrees
  factory Angle.a90() => Angle._(radians: math.pi / 2);

  /// Constructs an angle with 180 degrees
  factory Angle.a180() => Angle.half();

  /// Constructs an angle with 270 degrees
  factory Angle.a270() => Angle._(radians: 3 * math.pi / 2);

  /// Constructs an angle with 360 degrees
  factory Angle.a360() => Angle.full();

  /// Returns the distance between [a] and [b].
  /// The returned angle can never be over 180 degrees.
  static Angle getMinimalDistance(Angle a, Angle b) {
    // min{|α−β|, 360° −|α−β|}
    var diff = (a.normalized.radians - b.normalized.radians).abs();
    return Angle._(radians: math.min(diff, 2 * math.pi - diff));
  }

  /// Gets the closest angle out of [angles] to this.
  /// [angles] must contain at least one angle
  /// IMPORTANT: All angles are normalized!
  Angle getClosest(final List<Angle> angles) {
    if (angles.isEmpty) {
      throw ArgumentError('Angle list must contain at least one angle');
    }
    return angles.fold(angles[0], (previousAngle, currentAngle) {
      if (Angle.getMinimalDistance(this, currentAngle) <
          Angle.getMinimalDistance(this, previousAngle)) {
        return currentAngle;
      }
      return previousAngle;
    });
  }

  Angle abs() => Angle._(radians: _radians.abs());

  double sin() => math.sin(_radians);
  double cos() => math.cos(_radians);
  double tan() => math.tan(_radians);

  Angle operator -(Angle other) => Angle._(radians: _radians - other.radians);
  Angle operator -() => Angle._(radians: -_radians);
  Angle operator +(Angle other) => Angle._(radians: _radians + other.radians);
  Angle operator /(num divisor) => Angle._(radians: _radians / divisor);
  Angle operator *(dynamic factor) => Angle._(radians: _radians * factor);

  double ratio(final Angle other) => radians / other.radians;

  bool operator >(Angle other) => _radians > other.radians;
  bool operator <(Angle other) => _radians < other.radians;
  bool operator >=(Angle other) => _radians >= other.radians;
  bool operator <=(Angle other) => _radians <= other.radians;

  @override
  bool operator ==(Object other) {
    return (other is Angle) &&
        _radians.toPrecision(10) == other._radians.toPrecision(10);
  }

  @override
  int compareTo(Angle other) {
    if (this > other) {
      return 1;
    } else if (this < other) {
      return -1;
    }
    return 0;
  }

  @override
  int get hashCode => _radians.hashCode;

  @override
  String toString() => '${degrees.toStringAsFixed(2)}°';

  static double radiansToDegrees(final double radians) =>
      radians / math.pi * 180;
  static double radiansToTurns(final double radians) => radians / (2 * math.pi);
  static double radiansToGradians(final double radians) =>
      radians / math.pi * 200;

  static double degreesToRadians(final double degrees) =>
      degrees / 180 * math.pi;
  static double degreesToTurns(final double degrees) => degrees / 360;
  static double degreesToGradians(final double degrees) => degrees / 180 * 200;

  static double turnsToRadians(final double turns) => turns * 2 * math.pi;
  static double turnsToDegrees(final double turns) => turns * 360;
  static double turnsToGradians(final double turns) => turns * 400;

  static double gradiansToRadians(final double gradians) =>
      gradians / 200 * math.pi;
  static double gradiansToDegrees(final double gradians) =>
      gradians / 200 * 180;
  static double gradiansToTurns(final double gradians) => gradians / 400;
}
