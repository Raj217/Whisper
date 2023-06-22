import 'package:flutter/foundation.dart';

@immutable
class Exception extends Error {
  /// The message to be displayed when app is in release mode
  final String? _releaseMessage;

  /// The message to be displayed when app is in debug mode
  /// More description expected
  final String? _debugMessage;

  /// The default message to be displayed
  final String _defaultMessage = "Unknown Error";

  Exception({
    String? debugMessage,
    String? releaseMessage,
  })  : _releaseMessage = releaseMessage,
        _debugMessage = debugMessage;

  String getMessage() {
    if (kDebugMode) {
      return _debugMessage ?? _releaseMessage ?? _defaultMessage;
    } else {
      return _releaseMessage ?? _defaultMessage;
    }
  }

  @override
  String toString() {
    return 'default message: $_defaultMessage,'
        '\ndebug message: $_debugMessage,'
        '\nrelease message: $_releaseMessage';
  }
}
