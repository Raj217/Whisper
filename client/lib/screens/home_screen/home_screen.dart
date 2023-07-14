import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:whisper/packages/toast/toast.dart';
import 'package:whisper/utils/network_engine/network_engine.dart';
import 'package:whisper/widgets/app_decorations/app_decoration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/widgets/custom_app_bar/custom_app_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int page = 1;
  int perPage = 10;
  List<ImageInfo> images = [];
  Future<void> fetch() async {
    Response res = await NetworkEngine.getDio()
        .get("${NetworkEngine.searchRoute}?page=$page&perPage=$perPage");

    res.statusCode ??= 400;
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      for (var image in res.data) {
        images.add(image);
      }
    } else if (mounted) {
      showToast(context: context, text: res.data['message']);
    }
  }

  @override
  void initState() {
    super.initState();
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
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
