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
  int index = 0;
  bool isLoading = true;
  List<ImageInfoModel> images = [];
  PageController pageController = PageController();

  Future<void> fetch() async {
    List<ImageInfoModel> newImages =
        await ImageDatabase.randomImages(perPage: 2);
    setState(() {
      images.addAll(newImages);
    });
  }

  double animateToNextImage(double height) {
    index++;
    return (index * height) + MediaQuery.paddingOf(context).top;
  }

  double animateToPreviousImage(double height) {
    index--;
    if (index < 0) {
      index = 0;
    }
    return (index * height) + MediaQuery.paddingOf(context).top;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });
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
                if (index + 1 < images.length) {
                  pageController.animateToPage(
                    ((pageController.page ?? 1) + 1) ~/ 1,
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
