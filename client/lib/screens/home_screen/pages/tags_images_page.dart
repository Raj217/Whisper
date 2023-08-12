import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/database/database.dart';
import 'package:whisper/screens/home_screen/widgets/image_gallery.dart';
import 'package:whisper/states/image_browsing/image_browsing.dart';

class TagsImagesPage extends ConsumerWidget {
  const TagsImagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageBrowsingRef = ref.watch(imageBrowsingProvider.notifier);

    return ImageGallery(
      onImageChanged: (_) {
        print(imageBrowsingRef.imageInfo);
      },
      fetchImages: () async {
        print(
            "Fetching publisher ${imageBrowsingRef.imageInfo?.tags} images...");
        if (imageBrowsingRef.imageInfo?.publisherName == null) {
          return [];
        }
        List<ImageInfoModel> images = await ImageDatabase.tagsImage(
          page: imageBrowsingRef.publisherPageNo,
          perPage: 2, // widget.perPage,
          tags: imageBrowsingRef.imageInfo?.tags ?? [],
        );
        if (images.isNotEmpty) imageBrowsingRef.publisherPageNo++;
        return images;
      },
    );
  }
}
