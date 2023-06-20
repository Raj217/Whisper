import 'package:flutter/material.dart';
import 'configs/config.dart';
import 'screens/screens.dart';

void main() {
  runApp(const Whisper());
}

class Whisper extends StatelessWidget {
  const Whisper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: "Whisper",
      title: "Whisper",
      theme: lightTheme(context),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
        AuthScreen.routeName: (BuildContext context) => const AuthScreen(),
      },
    );
  }
}
