import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/rive/rive.dart';
import 'package:whisper/widgets/custom_app_bar/custom_app_bar.dart';

class SettingsScreen extends ConsumerWidget {
  static const String routeName = "/settingsScreen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        actions: [ThemeToggle(ref: ref, context: context)],
      ),
    );
  }
}
