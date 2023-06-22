import 'package:whisper/widgets/custom_overlay/custom_overlay.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LoadingOverlay extends CustomOverlay {
  LoadingOverlay._sharedInstance();
  static final LoadingOverlay _instance = LoadingOverlay._sharedInstance();
  factory LoadingOverlay.instance() => _instance;

  @override
  Widget overlayWidget(
    BuildContext context,
    StreamController<String?> textStream,
  ) {
    throw UnimplementedError();
  }
}
