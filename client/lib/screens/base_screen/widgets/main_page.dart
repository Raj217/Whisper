import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/screens/screens.dart';
import 'package:whisper/states/screen/screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> screens = const [
    HomeScreen(),
    SettingsScreen(),
  ];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: screens.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        ref.read(screenProvider.notifier).controller = tabController;
        return TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        );
      },
    );
  }
}
