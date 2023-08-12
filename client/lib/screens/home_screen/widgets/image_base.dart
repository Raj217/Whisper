import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/packages/database/database.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageBase extends StatelessWidget {
  final ImageInfoModel imageInfo;
  final bool updateLastViewedCheckpoint;
  const ImageBase({
    super.key,
    required this.imageInfo,
    required this.updateLastViewedCheckpoint,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageInfo.viewURL(
        height: MediaQuery.sizeOf(context).height.toInt() * 2,
        width: MediaQuery.sizeOf(context).width.toInt() * 2,
      ),
      fit: BoxFit.fitHeight,
      progressIndicatorBuilder:
          (BuildContext context, String _, DownloadProgress progress) {
        if (progress.progress == null && updateLastViewedCheckpoint) {
          UserDatabase.updateLastViewedCheckpoint(
            newCheckpoint: imageInfo.updatedAt,
          );
        }
        return Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              strokeCap: StrokeCap.round,
              color: whiteSwatch,
              value: progress.progress,
            ),
          ),
        );
      },
      errorWidget: (BuildContext context, String _, dynamic __) {
        return Center(
          child: Text(
            "Some error occurred. Couldn't fetch image.",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: whiteSwatch),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
