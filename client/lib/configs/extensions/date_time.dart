extension DateTimeExtension on DateTime {
  bool operator >(DateTime other) {
    return microsecondsSinceEpoch > other.microsecondsSinceEpoch;
  }
}
