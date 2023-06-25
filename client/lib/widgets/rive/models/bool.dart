part of rive_widgets;

abstract class RiveBool extends RiveBase<SMIBool> {
  final bool reverseBackAfterTransition;
  RiveBool({
    required super.src,
    required super.artBoard,
    required super.stateMachineName,
    required super.inputName,
    required super.duration,
    required super.isThemeIndependent,
    this.reverseBackAfterTransition = true,
  });

  @override
  bool changeState() {
    if (!isActive) {
      input.change(!input.value);
      if (reverseBackAfterTransition) {
        Future.delayed(duration, () => input.change(!input.value));
      }
      _lastTrigger = DateTime.now();
    }
    return input.value;
  }
}
