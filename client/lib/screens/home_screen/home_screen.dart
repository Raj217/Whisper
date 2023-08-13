import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/screens/home_screen/pages/random_images_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/screens/home_screen/widgets/filter_button.dart';
import 'package:whisper/widgets/filter_overlay/filter_overlay.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isOverlayOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      floatingActionButton: FilterButton(
        onTap: (bool menu) {
          setState(() {
            isOverlayOpen = menu;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SearchOverlay(
        isMenuOpen: isOverlayOpen,
        child: const RandomImagesPage(),
      ),
    );
  }
}
