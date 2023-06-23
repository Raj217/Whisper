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
    return Material(
      color: Colors.black.withOpacity(0.1),
      child: const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            strokeWidth: 5,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
    );
  }
}
