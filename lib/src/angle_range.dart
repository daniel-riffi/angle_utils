import 'angle.dart';

/// Represents an angle range.
class AngleRange {
  late Angle _start;
  late Angle _sweep;
  late Angle _end;
  late Angle _mid;

  Angle get start => _start;
  Angle get sweep => _sweep;
  Angle get end => _end;
  Angle get mid => _mid;

  AngleRange({required Angle start, required Angle end}) {
    _start = start;
    _end = end;
    _sweep = _end - _start;
    _mid = _start + _sweep / 2;
  }

  factory AngleRange.fromSweep(Angle start, Angle sweep) {
    return AngleRange(start: start, end: start + sweep);
  }

  /// Constructs an angle range from the given [mid] angle by adding and substracting [delta].
  factory AngleRange.fromDelta(Angle mid, Angle delta) {
    if(delta.isNegative) {
      throw ArgumentError('Delta angle must be positiv');
    }
    return AngleRange(start: mid - delta, end: mid + delta);
  }

  /// Checks whether the given [angle] is in this angle range
  /// Note: [from] can be greater than [to], but then the range spans over the angle zero
  bool includes(Angle angle) {
    if (_start < _end) {
      return _start <= angle && angle <= _end;
    } else if (_start > _end) {
      return _start <= angle || angle <= _end;
    }
    return angle == _start;
  }

  @override
  bool operator ==(Object other) {
    return (other is AngleRange) && other._start == _start && other._end == _end;
  }

  @override
  int get hashCode => Object.hash(_start, _end);

  @override
  String toString() {
    return 'AngleRange(from: $_start, to: $_end)';
  }
}