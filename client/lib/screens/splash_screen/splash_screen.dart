import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whisper/states/auth/auth.dart';
import 'package:whisper/widgets/decorations/decorations.dart';
import 'package:whisper/firebase_options.dart';
import 'package:whisper/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveToNextPage() {
    if (Authenticator.isLoggedIn()) {
      Navigator.pushNamed(context, BaseScreen.routeName)
          .then((value) => exit(0));
    } else {
      Navigator.pushNamed(context, AuthScreen.routeName)
          .then((value) => exit(0));
    }
  }

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await Future.delayed(const Duration(milliseconds: 500));
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
