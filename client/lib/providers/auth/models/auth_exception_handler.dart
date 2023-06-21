part of auth;

Future<AuthResult> operate(
  Future Function() task, {
  String? successDebugMessage,
  String? successReleaseMessage,
}) async {
  try {
    await task();
    return AuthResult.success(
      successDebugMessage,
      successReleaseMessage,
    );
  } on PlatformException catch (e) {
    return AuthResult.aborted(
      e.toString(),
      e.message,
    );
  } on FirebaseAuthMultiFactorException catch (e) {
    return AuthResult.failure(
      e.code,
      getFirebaseExceptionMessageFromErrorCode(e.code),
    );
  } catch (e) {
    return AuthResult.failure(
      e.toString(),
    );
  }
}
