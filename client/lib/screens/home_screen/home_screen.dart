import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:whisper/packages/toast/toast.dart';
import 'package:whisper/packages/network_engine/network_engine.dart';
import 'package:whisper/packages/storage/storage.dart';
import 'package:whisper/widgets/app_decorations/app_decoration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/widgets/custom_app_bar/custom_app_bar.dart';
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
  List<ImageInfoModel> images = [];
  ScrollController scrollController = ScrollController();

  void fetch() async {
    List<ImageInfoModel> newImages = await ImageDatabase.randomImages();
    setState(() {
      images.addAll(newImages);
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 4,
          itemCount: images.length,
          controller: scrollController,
          itemBuilder: (context, ind) {
            return Image(
              image: NetworkImage(images[ind].thumbnailURL()),
              loadingBuilder: (BuildContext context, Widget imageWidget,
                  ImageChunkEvent? chunk) {
                double? progress = chunk == null ||
                        chunk.expectedTotalBytes == null
                    ? null
                    : chunk.cumulativeBytesLoaded / chunk.expectedTotalBytes!;

                if (progress == 1 || progress == null) {
                  UserDatabase.updateLastViewedCheckpoint(
                    newCheckpoint: images[ind].updatedAt,
                  );
                }
                return progress == 1 || progress == null
                    ? imageWidget
                    : Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                            strokeCap: StrokeCap.round,
                            value: progress,
                          ),
                        ),
                      );
              },
              errorBuilder: (_, __, ___) {
                // print(images[ind].thumbnailURL);
                return Container();
              },
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}
