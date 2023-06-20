import 'package:flutter/material.dart';
import 'package:whisper/screens/auth_screen/auth_screen.dart';
import 'package:whisper/widgets/app_decorations/whisper_icon.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveToNextPage() {
    Navigator.pushNamed(context, AuthScreen.routeName);
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
        child: WhisperIcon(),
      ),
    );
  }
}
