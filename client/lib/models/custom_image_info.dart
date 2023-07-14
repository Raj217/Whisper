import 'dart:ui';
import 'package:whisper/configs/extensions/color.dart';

class CustomImageInfo {
  final String publisherName;
  final String publisherURL;
  final List<String> tags;
  final Color color;
  final String thumbnailURL;
  final String viewURL;
  final String downloadURL;
  CustomImageInfo({
    required this.publisherName,
    required this.publisherURL,
    required this.tags,
    required this.color,
    required this.thumbnailURL,
    required this.viewURL,
    required this.downloadURL,
  });

  static CustomImageInfo fromJSON(data) {
    return CustomImageInfo(
      publisherName: data['publisherName'],
      publisherURL: data['publisherURL'],
      tags: List<String>.from(data['tags']),
      color: ColorExtension.fromHEX(data['color']),
      thumbnailURL: data['images']['thumbnail'],
      viewURL: data['images']['view'],
      downloadURL: data['images']['download'],
    );
  }
}
