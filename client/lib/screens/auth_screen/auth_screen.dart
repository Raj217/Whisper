import 'package:flutter/material.dart';
import 'package:whisper/widgets/decorations/decorations.dart';
import 'widgets/google_sign_in_button.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = "/authScreen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const WhisperIcon(size: 100),
                const SizedBox(height: 60),
                WhisperText(
                  mainTextStyle: Theme.of(context).textTheme.headlineLarge,
                  showMessage: true,
                ),
              ],
            ),
            const Center(child: GoogleSignInButton()),
          ],
        ),
      ),
    );
  }
}
