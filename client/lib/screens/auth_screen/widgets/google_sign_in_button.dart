import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/states/auth/auth.dart';
import 'package:whisper/screens/base_screen/base_screen.dart';
import 'package:whisper/packages/custom_overlays/custom_overlay.dart';
import 'package:whisper/packages/toast/toast.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        LoadingOverlay.instance().show(context: context);
        AuthResult res = await Authenticator.logInWithGoogle();
        if (context.mounted) {
          LoadingOverlay.instance().hide();

          if (res.code == AuthCode.success) {
            Navigator.pushNamed(
              context,
              BaseScreen.routeName,
              arguments: res.getMessage(),
            );
          } else {
            showToast(context: context, text: res.getMessage());
          }
        }
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
