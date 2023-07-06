import 'package:flutter/cupertino.dart';
import 'package:whisper/states/auth/auth.dart';
import 'package:whisper/packages/rive/rive.dart';
import 'package:whisper/screens/screens.dart';

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

List<void Function(BuildContext)?> onTapped = [
  null,
  null,
  (context) async {
    await Future.delayed(const Duration(milliseconds: 300));
    await Authenticator.logOut();
    if (context.mounted) {
      Navigator.pushNamed(context, AuthScreen.routeName);
    }
  },
];
