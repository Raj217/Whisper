import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'configs/config.dart';
import 'screens/screens.dart';
import 'firebase_options.dart';
import 'states/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: Whisper()));
}

class Whisper extends ConsumerWidget {
  const Whisper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);
    return MaterialApp(
      restorationScopeId: "Whisper",
      title: "Whisper",
      darkTheme: darkTheme(context),
      theme: lightTheme(context),
      themeMode: themeModeState,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
        HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
        AuthScreen.routeName: (BuildContext context) => const AuthScreen(),
      },
    );
  }
}
