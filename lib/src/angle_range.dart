import 'angle.dart';

/// Represents an angle range.
class AngleRange {
  late final Angle _start;
  late final Angle _sweep;
  late final Angle _end;
  late final Angle _mid;

  Angle get start => _start;
  Angle get sweep => _sweep;
  Angle get end => _end;
  Angle get mid => _mid;

  AngleRange get normalized =>
      AngleRange(start: _start.normalized, end: _end.normalized);

  /// Constructs an angle range from the given [start] and [end] angle
  /// An angle range can NOT be over 360 degrees
  AngleRange({required Angle start, required Angle end}) {
    _start = start;
    _end = end;
    if ((_end - _start).abs() > Angle.full()) {
      throw ArgumentError('Angle range can not be greater than 360 degrees');
    }
    _sweep = (_end - _start).normalized;
    _mid = _start + _sweep / 2;
  }

  /// Constructs and angle range from a [start] and a [sweep] angle
  factory AngleRange.fromSweep(Angle start, Angle sweep) {
    return AngleRange(start: start, end: start + sweep);
  }

  /// Constructs an angle range from the given [mid] angle by adding and substracting [delta].
  factory AngleRange.fromDelta(Angle mid, Angle delta) {
    if (delta.isNegative) {
      throw ArgumentError('Delta angle must be positiv');
    }
    return AngleRange(start: mid - delta, end: mid + delta);
  }

  /// Constructs an angle range where [start] and [end] are normalized
  factory AngleRange.normalized(Angle start, Angle end) {
    return AngleRange(start: start.normalized, end: end.normalized);
  }

  /// Checks whether the given [angle] is in this normalized angle range
  /// Note: [start] can be greater than [end], but then the range spans over angle zero
  bool includesNormalized(Angle angle) {
    var normalizedRange = normalized;
    var normalizedAngle = angle.normalized;
    if (normalizedRange.start < normalizedRange.end) {
      return normalizedRange.start <= normalizedAngle &&
          normalizedAngle <= normalizedRange.end;
    } else if (normalizedRange.start > normalizedRange.end) {
      return normalizedRange.start <= normalizedAngle ||
          normalizedAngle <= normalizedRange.end;
    }
    return normalizedAngle == normalizedRange.start;
  }

  /// Checks whether the given [angle] is in this angle range
  bool includes(Angle angle) {
    return _start <= angle && angle <= _end;
  }

  @override
  bool operator ==(Object other) {
    return (other is AngleRange) &&
        other._start == _start &&
        other._end == _end;
  }

  @override
  int get hashCode => Object.hash(_start, _end);

  @override
  String toString() => '$_start to $_end';
}
