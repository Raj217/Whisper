import 'package:flutter/material.dart';
import 'package:whisper/packages/database/database.dart';
import 'package:whisper/widgets/decorations/decorations.dart';
import 'image_base.dart';

class ImageCard extends StatelessWidget {
  final ImageInfoModel imageInfo;
  final bool updateLastViewedCheckpoint;
  const ImageCard(
      {super.key,
      required this.imageInfo,
      required this.updateLastViewedCheckpoint});

  @override
  Widget build(BuildContext context) {
    return Vignette(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: ImageBase(
          imageInfo: imageInfo,
          updateLastViewedCheckpoint: updateLastViewedCheckpoint,
        ),
      ),
    );
  }
}
