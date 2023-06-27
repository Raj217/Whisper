import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whisper/states/auth/auth.dart';
import 'package:whisper/screens/auth_screen/auth_screen.dart';
import 'package:whisper/widgets/app_decorations/whisper_icon.dart';
import 'package:whisper/firebase_options.dart';
import 'package:whisper/screens/screen_base/screen_base.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveToNextPage() {
    if (true || Authenticator.isLoggedIn()) {
      Navigator.pushNamed(context, ScreenBase.routeName)
          .then((value) => exit(0));
    } else {
      Navigator.pushNamed(context, AuthScreen.routeName)
          .then((value) => exit(0));
    }
  }

  Future<void> init() async {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  void initState() {
    super.initState();
    init().then((value) => moveToNextPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: WhisperIcon(size: 100),
      ),
    );
  }
}
