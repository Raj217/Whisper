part of rive_widgets;

abstract class RiveTrigger {
  final String src;
  final String artBoard;
  late final SMITrigger _input;
  final String stateMachineName;
  final String inputName;
  final Duration duration;
  late final StateMachineController? controller;
  DateTime? _lastTrigger;
  RiveTrigger({
    required this.src,
    required this.artBoard,
    required this.stateMachineName,
    required this.inputName,
    required this.duration,
  });

  bool get isActive =>
      _lastTrigger != null &&
      DateTime.now().difference(_lastTrigger!) <= duration;

  bool changeSMIBoolState() {
    if (!isActive) {
      _input.fire();
      _lastTrigger = DateTime.now();
    }
    return true;
  }

  void getRiveInputBool(Artboard artBoard) {
    controller = StateMachineController.fromArtboard(
      artBoard,
      stateMachineName,
    );
    artBoard.addController(controller!);
    _input = controller?.findInput<bool>(inputName) as SMITrigger;
  }
}
