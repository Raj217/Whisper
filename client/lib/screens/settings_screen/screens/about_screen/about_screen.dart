import 'package:flutter/material.dart';
import 'package:whisper/widgets/custom_app_bar/custom_app_bar.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = "/settingsScreen/AboutScreen";
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        children: [],
        automaticallyImplyLeading: true,
        context: context,
      ),
    );
  }
}
