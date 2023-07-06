import 'package:flutter/material.dart';
import 'package:whisper/widgets/custom_app_bar/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "/settingsScreen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        children: [
          Text(
            "Settings",
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
