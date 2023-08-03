import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/screens/home_screen/widgets/image_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/database/database.dart';
import 'widgets/fetch_more_indicator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int perPage = 10;
  bool isLoading = true;
  List<ImageInfoModel> images = [];
  PageController pageController = PageController();

  Future<void> fetch() async {
    List<ImageInfoModel> newImages =
        await ImageDatabase.randomImages(perPage: perPage);
    setState(() {
      images.addAll(newImages);
    });
  }

  @override
  void initState() {
    super.initState();

    fetch().then(
      (value) => setState(() {
        isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                strokeCap: StrokeCap.round,
                color: whiteSwatch,
              ),
            )
          : FetchMoreIndicator(
              fetchFunction: () async {
                await fetch();
                double? page = pageController.page;
                if (page != null && page + 1 < images.length) {
                  pageController.animateToPage(
                    (page + 1).toInt(),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              child: PageView.builder(
                itemCount: images.length,
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, ind) {
                  return ImageCard(imageInfo: images[ind]);
                },
              ),
            ),
    );
  }
}
