part of rive_widgets;

abstract class RiveTrigger {
  final String src;
  late final SMITrigger input;
  final String stateMachineName;
  final String inputName;
  RiveTrigger({
    required this.src,
    required this.stateMachineName,
    required this.inputName,
  });

  bool changeSMIBoolState() {
    input.fire();
    return input.value;
  }

  SMITrigger getRiveInputBool(Artboard artBoard) {
    StateMachineController? controller = StateMachineController.fromArtboard(
      artBoard,
      stateMachineName,
    );
    artBoard.addController(controller!);
    return controller.findInput<bool>(inputName) as SMITrigger;
  }
}
