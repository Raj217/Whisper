import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/providers/auth/auth.dart';
import 'package:whisper/screens/auth_screen/auth_screen.dart';
import 'package:whisper/screens/home_screen/home_screen.dart';
import 'package:whisper/widgets/app_decorations/whisper_icon.dart';
import 'package:whisper/widgets/rive/rive.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveToNextPage() {
    if (Authenticator.isLoggedIn()) {
      Navigator.pushNamed(context, HomeScreen.routeName)
          .then((value) => exit(0));
    } else {
      Navigator.pushNamed(context, AuthScreen.routeName)
          .then((value) => exit(0));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      moveToNextPage();
    });
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
