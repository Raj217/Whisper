import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/rive/rive.dart';
import 'package:whisper/states/screen/screen.dart';
import 'package:whisper/widgets/custom_app_bar/custom_app_bar.dart';
import 'widgets/item.dart';
import 'data/settings_data.dart';

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
        actions: [
          ThemeToggle(ref: ref, context: context),
        ],
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int ind) {
            return Item(
              title: titles[ind],
              onPressed: () {
                Navigator.pushNamed(context, routes[ind]);
              },
            );
          },
          separatorBuilder: (BuildContext context, int ind) {
            return const SizedBox(height: 15);
          },
          itemCount: titles.length,
        ),
      ),
    );
  }
}
