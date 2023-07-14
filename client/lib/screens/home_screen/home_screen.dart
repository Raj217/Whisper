import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:whisper/packages/custom_overlays/custom_overlay.dart';
import 'package:whisper/packages/toast/toast.dart';
import 'package:whisper/utils/network_engine/network_engine.dart';
import 'package:whisper/utils/storage/storage.dart';
import 'package:whisper/widgets/app_decorations/app_decoration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:whisper/models/custom_image_info.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int page = 1;
  int perPage = 10;
  List<CustomImageInfo> images = [];
  ScrollController scrollController = ScrollController();

  Future<void> fetch() async {
    // LoadingOverlay.instance().show(context: context);
    Response res = await NetworkEngine.getDio()
        .get("${NetworkEngine.searchRoute}?page=${page++}&perPage=$perPage");

    res.statusCode ??= 400;
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      setState(() {
        for (var image in res.data['results']) {
          images.add(CustomImageInfo.fromJSON(image));
        }
        images;
      });
    } else if (mounted) {
      showToast(context: context, text: res.data['message']);
    }

    // if (mounted) LoadingOverlay.instance().hide();
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
        child: GridView.builder(
          itemCount: images.length,
          controller: scrollController,
          itemBuilder: (BuildContext context, int ind) {
            return Image(
              image: NetworkImage(images[ind].thumbnailURL, headers: {
                'Authorization': StorageHandler.instance
                        .getString(StoredValues.token.name) ??
                    '',
              }),
              errorBuilder: (_, __, ___) {
                print(images[ind].thumbnailURL);
                return Container();
              },
              fit: BoxFit.cover,
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
        ),
      ),
    );
  }
}
