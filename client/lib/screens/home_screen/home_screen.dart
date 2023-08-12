import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/screens/home_screen/pages/publisher_images_page.dart';
import 'package:whisper/screens/home_screen/pages/tags_images_page.dart';
import 'package:whisper/screens/home_screen/pages/random_images_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/states/image_browsing/image_browsing.dart';
import 'package:whisper/packages/database/database.dart';

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

  @override
  Widget build(BuildContext context) {
    ImageBrowsingModel imageBrowsingModel = ref.watch(imageBrowsingProvider);
    return Scaffold(
      backgroundColor: black,
      body: imageBrowsingModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                strokeCap: StrokeCap.round,
                color: whiteSwatch,
              ),
            )
          : PageView(
              controller: pageController,
              onPageChanged: (int pageIndex) {
                final imageBrowsingRef =
                    ref.read(imageBrowsingProvider.notifier);
                if (pageIndex == 1) {
                  imageBrowsingRef.reset();
                }
              },
              children: pages,
            ),
    );
  }
}
