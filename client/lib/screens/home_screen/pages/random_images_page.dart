import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/database/database.dart';
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
        return await ImageDatabase.randomImages(perPage: perPage);
      },
    );
  }
}
