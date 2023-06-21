part of auth;

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(super._state);

  bool get isLoggedIn => user != null;
  User? get user => FirebaseAuth.instance.currentUser;
}
