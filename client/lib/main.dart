import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'configs/config.dart';
import 'screens/screens.dart';
import 'states/theme/theme.dart';
import 'utils/storage/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        ScreenBase.routeName: (BuildContext context) => const ScreenBase(),
        HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
        AuthScreen.routeName: (BuildContext context) => const AuthScreen(),
      },
    );
  }
}
