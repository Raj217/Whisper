part of rive_widgets;

abstract class RiveTriggerController extends RiveController<SMITrigger, bool> {
  RiveTriggerController({
    required super.src,
    required super.artBoard,
    required super.stateMachineName,
    required super.inputName,
    required super.isThemeIndependent,
    required super.duration,
  });

  @override
  bool changeState() {
    if (!isActive) {
      input.fire();
      _lastTrigger = DateTime.now();
      return true;
    }
    return false;
  }
}
