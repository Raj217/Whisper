part of custom_overlay;

abstract class CustomOverlay {
  OverlayController? controller;

  void show({
    required BuildContext context,
    String? text,
    Duration? duration,
  }) {
    if (controller?._update(text) ?? false) {
      return;
    } else {
      controller = showOverlay(context, text);
    }
  }

  void hide() {
    controller?._close();
    controller = null;
  }

  /// Update this function as per the overlay
  Widget overlayWidget(
      BuildContext context, StreamController<String?> textStream) {
    return Container();
  }

  OverlayController? showOverlay(BuildContext context, String? text) {
    final textController = StreamController<String?>();
    textController.add(text);

    final OverlayState state = Overlay.of(context);

    final overlay = OverlayEntry(
      builder: (BuildContext ctx) => overlayWidget(
        context,
        textController,
      ),
    );

    state.insert(overlay);

    return OverlayController(
      close: () {
        textController.close();
        overlay.remove();
        return true;
      },
      update: (String? text) {
        textController.add(text);
        return true;
      },
    );
  }
}
