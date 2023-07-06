import 'package:flutter/material.dart';
import 'package:whisper/widgets/app_decorations/app_decoration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/widgets/custom_app_bar/custom_app_bar.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        context: context,
        children: const [
          WhisperIcon(),
          SizedBox(width: 10),
          WhisperText(),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
