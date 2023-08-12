import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/database/database.dart';
import 'package:whisper/screens/home_screen/widgets/image_gallery.dart';
import 'package:whisper/states/image_browsing/image_browsing.dart';

class PublisherImagesPage extends ConsumerStatefulWidget {
  final int perPage;
  const PublisherImagesPage({
    super.key,
    this.perPage = 10,
  });

  @override
  ConsumerState createState() => _PublisherImagesPageState();
}

class _PublisherImagesPageState extends ConsumerState<PublisherImagesPage> {
  @override
  Widget build(BuildContext context) {
    final imageBrowsingRef = ref.read(imageBrowsingProvider.notifier);

    return ImageGallery(
      onImageChanged: (_) {
        print(imageBrowsingRef.imageInfo);
      },
      fetchImages: () async {
        print(
            "Fetching publisher ${imageBrowsingRef.imageInfo?.publisherName} images...");
        if (imageBrowsingRef.imageInfo?.publisherName == null) {
          return [];
        }
        List<ImageInfoModel> images = await ImageDatabase.publisherImages(
          page: imageBrowsingRef.publisherPageNo,
          perPage: 2, // widget.perPage,
          publisherName: imageBrowsingRef.imageInfo!.publisherName!,
          source: imageBrowsingRef.imageInfo!.source,
        );
        if (images.isNotEmpty) imageBrowsingRef.publisherPageNo++;
        return images;
      },
    );
  }
}
