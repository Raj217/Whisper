import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/database/database.dart';
import 'package:whisper/states/image_browsing/image_browsing.dart';
import '../widgets/image_gallery.dart';

class RandomImagesPage extends ConsumerWidget {
  final int perPage;
  const RandomImagesPage({
    super.key,
    this.perPage = 10,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ImageGallery(
      updateLastViewedCheckpoint: true,
      fetchImages: () async {
        print("Fetching random images...");
        return await ImageDatabase.randomImages(perPage: perPage);
      },
      onImageChanged: (ImageInfoModel imageInfo) {
        ref.read(imageBrowsingProvider.notifier).imageInfo = imageInfo;
        print(ref.read(imageBrowsingProvider.notifier).imageInfo);
      },
    );
  }
}
