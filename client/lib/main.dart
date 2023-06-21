import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'configs/config.dart';
import 'screens/screens.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
