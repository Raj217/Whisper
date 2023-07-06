import 'package:flutter/material.dart';
import 'package:whisper/widgets/app_decorations/app_decoration.dart';
import 'package:whisper/widgets/rive/rive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = "/homeScreen";
  HomeScreen({Key? key}) : super(key: key);

  RiveThemeToggleController theme = RiveThemeToggleController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 60),
            WhisperIcon(),
            SizedBox(width: 10),
            WhisperText(),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
