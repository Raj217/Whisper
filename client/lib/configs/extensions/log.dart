import 'package:flutter/foundation.dart';

extension Log on Object {
  void log() {
    if (kDebugMode) {
      print(toString());
    }
  }
}
