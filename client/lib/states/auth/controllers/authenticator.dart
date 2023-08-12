part of auth;

@immutable
class Authenticator {
  const Authenticator._();

  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser?.uid != null;
  }

  static Future<AuthResult> logInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Initiate Google Sign In
    GoogleSignInAccount? account;
    AuthResult response = await AuthResult.operate(
      () async => account = await googleSignIn.signIn(),
    );
    if (response.code != AuthCode.success) return response;

    if (account == null) {
      return AuthResult.aborted("User aborted", "");
    }

    final GoogleSignInAuthentication authentication =
        await account!.authentication;
    final OAuthCredential credentials = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );
    print(authentication.idToken);

    // Authenticate with firebase
    AuthResult res = await AuthResult.operate(
      () async {
        await FirebaseAuth.instance.signInWithCredential(credentials);
        await UserDatabase.createUser();
      },
      successDebugMessage: "Signed in with firebase",
      successReleaseMessage: "Welcome to Whisper",
    );

    return res;
  }
}
