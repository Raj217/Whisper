import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/screens/home_screen/pages/publisher_images_page.dart';
import 'package:whisper/screens/home_screen/pages/tags_images_page.dart';
import 'package:whisper/screens/home_screen/pages/random_images_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/screens/home_screen/widgets/filter_button.dart';
import 'package:whisper/widgets/filter_overlay/filter_overlay.dart';
import 'package:whisper/states/image_browsing/image_browsing.dart';
import '../../widgets/filter_overlay/filter_overlay.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Widget> pages = const [
    PublisherImagesPage(),
    RandomImagesPage(),
    TagsImagesPage(),
  ];
  PageController pageController = PageController(initialPage: 1);
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    ImageBrowsingModel imageBrowsingModel = ref.watch(imageBrowsingProvider);
    return Scaffold(
      backgroundColor: black,
      floatingActionButton: FilterButton(
        onTap: (bool menu) {
          setState(() {
            isMenuOpen = menu;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: imageBrowsingModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                strokeCap: StrokeCap.round,
                color: whiteSwatch,
              ),
            )
          : FilterOverlay(
              isMenuOpen: isMenuOpen,
              child: PageView(
                controller: pageController,
                onPageChanged: (int pageIndex) {
                  final imageBrowsingRef =
                      ref.read(imageBrowsingProvider.notifier);
                  if (pageIndex == 1) {
                    imageBrowsingRef.reset();
                    print("Filters reset");
                  }
                },
                children: pages,
              ),
            ),
    );
  }
}
