extension NumExtension on num {
  num toPrecision(int precision) {
    return num.parse((this).toStringAsFixed(precision));
  }
}
