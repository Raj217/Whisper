import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whisper/screens/home_screen/widgets/image_card.dart';
import 'package:whisper/widgets/decorations/decorations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/database/database.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int page = 1;
  int perPage = 10;
  int index = 0;
  List<ImageInfoModel> images = [];
  PageController pageController = PageController();

  void fetch() async {
    List<ImageInfoModel> newImages = await ImageDatabase.randomImages();
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
    fetch();
    pageController.addListener(() {
      if (pageController.position.maxScrollExtent == pageController.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: images.length,
        controller: pageController,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, ind) {
          return ImageCard(imageInfo: images[ind]);
        },
      ),
    );
  }
}
