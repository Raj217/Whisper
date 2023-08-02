import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/packages/database/database.dart';

class ImageBase extends StatelessWidget {
  final ImageInfoModel imageInfo;
  const ImageBase({super.key, required this.imageInfo});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(
        imageInfo.viewURL(
          height: MediaQuery.sizeOf(context).height.toInt(),
          width: MediaQuery.sizeOf(context).width.toInt(),
        ),
      ),
      fit: BoxFit.fitHeight,
      loadingBuilder:
          (BuildContext context, Widget imageWidget, ImageChunkEvent? chunk) {
        double? progress = chunk == null || chunk.expectedTotalBytes == null
            ? null
            : chunk.cumulativeBytesLoaded / chunk.expectedTotalBytes!;

        if (progress == 1 || progress == null) {
          UserDatabase.updateLastViewedCheckpoint(
            newCheckpoint: imageInfo.updatedAt,
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
                    color: whiteSwatch,
                    value: progress,
                  ),
                ),
              );
      },
      errorBuilder: (_, __, ___) {
        return Container();
      },
    );
  }
}
