import 'package:flutter/material.dart';
import 'package:whisper/widgets/app_decorations/app_decoration.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            WhisperIcon(),
            SizedBox(width: 10),
            WhisperText(),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(),
      ),
    );
  }
}
