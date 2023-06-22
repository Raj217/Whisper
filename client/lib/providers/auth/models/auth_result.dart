part of auth;

enum AuthCode { success, failure, aborted }

class AuthResult extends Exception {
  final AuthCode code;
  AuthResult({required this.code, String? debugMessage, String? releaseMessage})
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

  /// Perform a task and return the result in a suitable format
  /// so that user knows what's going on
  static Future<AuthResult> operate(
    Future Function() task, {
    String? successDebugMessage,
    String? successReleaseMessage,
  }) async {
    try {
      await task();
      return success(successDebugMessage, successReleaseMessage);
    } on PlatformException catch (e) {
      return aborted(e.toString(), e.message);
    } on FirebaseAuthMultiFactorException catch (e) {
      return failure(e.code, getFirebaseExceptionMessageFromErrorCode(e.code));
    } catch (e) {
      return failure(e.toString());
    }
  }

  @override
  String toString() {
    return '${super.toString()},'
        '\nAuth result: $code';
  }
}
