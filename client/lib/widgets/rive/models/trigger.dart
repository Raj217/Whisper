part of rive_widgets;

abstract class RiveTrigger extends RiveBase<SMITrigger, bool> {
  RiveTrigger({
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
    }
    return true;
  }
}
