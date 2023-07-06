part of custom_overlay;

typedef CloseOverlay = bool Function();
typedef UpdateOverlay = bool Function(String?);

class OverlayController {
  final CloseOverlay _close;
  final UpdateOverlay _update;
  OverlayController(
      {required CloseOverlay close, required UpdateOverlay update})
      : _close = close,
        _update = update;
}
