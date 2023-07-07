import 'package:flutter/cupertino.dart';
import 'package:whisper/states/auth/auth.dart';
import 'package:whisper/packages/rive/rive.dart';
import 'package:whisper/screens/screens.dart';
import 'package:whisper/states/screen/screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> menuTitle = [
  "Home",
  "Settings",
  "Log Out",
];

List<RiveController?> controllers = [
  RiveHomeIconController(),
  RiveSettingsIconController(),
  null,
];

List<RiveWidgetBase?> icons = [
  HomeIcon(),
  SettingsIcon(),
  null,
];

List<void Function(BuildContext, WidgetRef)?> onTapped = [
  null,
  null,
  (context, ref) async {
    await Authenticator.logOut();
    if (context.mounted) {
      ref.read(screenProvider).isMenuOpen = false;
      Navigator.pushNamed(context, AuthScreen.routeName);
    }
  },
];
