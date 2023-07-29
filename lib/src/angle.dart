import 'dart:core';
import 'dart:math' as math;

/// Represents an angle.
/// Internally the angle is stored in radians.
class Angle implements Comparable<Angle> {
  late double _radians;

  bool get isZero => _radians == 0;

  bool get isPositive => _radians >= 0;
  bool get isNegative => _radians < 0;

  Angle get normalized {
    var remainder = _radians.remainder(2*math.pi);
    if(isPositive) {
      return Angle.radians(remainder);
    }
    else {
      return Angle.full() + Angle.radians(remainder);
    }
  }

  double get radians => _radians;
  double get degrees => Angle.radiansToDegrees(_radians);

  Angle({required double radians}) : _radians = radians;

  Angle.degrees(final double degrees) : _radians = Angle.degreesToRadians(degrees);
  Angle.radians(final double radians) : _radians = radians;

  Angle.atan2(num a, num b): _radians = math.atan2(a, b);

  factory Angle.zero() => Angle(radians: 0);
  factory Angle.half() => Angle(radians: math.pi);
  factory Angle.full() => Angle(radians: 2*math.pi);

  factory Angle.a0() => Angle.zero();
  factory Angle.a90() => Angle(radians: math.pi/2);
  factory Angle.a180() => Angle.half();
  factory Angle.a270() => Angle(radians: 3 * math.pi / 2);
  factory Angle.a360() => Angle.full();

  /// Returns the distance between this and [other].
  /// The returned angle can never be over 180 degrees.
  Angle distance(Angle other) {
    // min{|α−β|, 360° −|α−β|}
    var diff = (normalized.radians - other.normalized.radians).abs();
    return Angle(radians: math.min(diff, 2*math.pi - diff));
  }

  Angle abs() => Angle(radians: _radians.abs());

  double sin() => math.sin(_radians);
  double cos() => math.cos(_radians);
  double tan() => math.tan(_radians);

  Angle operator -(Angle other) => Angle(radians: _radians - other.radians);
  Angle operator -() => Angle(radians: -_radians);
  Angle operator +(Angle other) => Angle(radians: _radians + other.radians);
  Angle operator /(num divisor) => Angle(radians: _radians / divisor);
  Angle operator *(dynamic factor) => Angle(radians: _radians * factor);

  bool operator >(Angle other) => _radians > other.radians;
  bool operator <(Angle other) => _radians < other.radians;
  bool operator >=(Angle other) => _radians >= other.radians;
  bool operator <=(Angle other) => _radians <= other.radians;

  @override
  bool operator ==(Object other) {
    return (other is Angle) && _radians == other._radians;
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
  String toString() {
    return 'Angle(radians: $_radians, degrees: $degrees)';
  }

  static double degreesToRadians(double degrees) {
    return degrees / 180 * math.pi;
  }

  static double radiansToDegrees(double radians) {
    return radians / math.pi * 180;
  }
}
