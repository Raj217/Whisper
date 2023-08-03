import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'configs/config.dart';
import 'screens/screens.dart';
import 'states/theme/theme.dart';
import 'packages/storage/storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await StorageHandler.init();

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
        SettingsScreen.routeName: (BuildContext context) =>
            const SettingsScreen(),
        AboutScreen.routeName: (BuildContext context) => const AboutScreen(),
        BaseScreen.routeName: (BuildContext context) => const BaseScreen(),
        AuthScreen.routeName: (BuildContext context) => const AuthScreen(),
      },
    );
  }
}
