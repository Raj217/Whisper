import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/providers/auth/auth.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        AuthResult res = await Authenticator.logInWithGoogle();
        res.log();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
            child: Image.asset(
              ImagePath().googleLogo,
            ),
          ),
          const SizedBox(width: 40),
          const Text('Sign in with Google'),
        ],
      ),
    );
  }
}
