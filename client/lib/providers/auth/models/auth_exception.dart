part of auth;

enum AuthCode { success, failure, aborted }

class AuthResult extends Exception {
  final AuthCode code;
  AuthResult(
      {required this.code, String? debugMessage, String? releaseMessage})
      : super(
          debugMessage: debugMessage,
          releaseMessage: releaseMessage,
        );

  static AuthResult aborted([String? debugMessage, String? releaseMessage]) {
    return AuthResult(
      code: AuthCode.aborted,
      debugMessage: debugMessage,
      releaseMessage: releaseMessage,
    );
  }

  static AuthResult failure([String? debugMessage, String? releaseMessage]) {
    return AuthResult(
      code: AuthCode.failure,
      debugMessage: debugMessage,
      releaseMessage: releaseMessage,
    );
  }

  static AuthResult success([String? debugMessage, String? releaseMessage]) {
    return AuthResult(
      code: AuthCode.success,
      debugMessage: debugMessage,
      releaseMessage: releaseMessage,
    );
  }

  @override
  String toString() {
    return '''
      ${super.toString()},
      Auth result: $code
    ''';
  }
}
