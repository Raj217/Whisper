part of rive_widgets;

abstract class RiveBase<T extends SMIInput<U>, U> {
  final String _src;
  final String artBoard;
  late T input;
  final String stateMachineName;
  final String inputName;
  final bool isThemeIndependent;
  DateTime? _lastTrigger;
  final Duration duration;
  RiveBase({
    required String src,
    required this.artBoard,
    required this.stateMachineName,
    required this.inputName,
    required this.isThemeIndependent,
    DateTime? lastTrigger,
    required this.duration,
  })  : _src = src,
        _lastTrigger = lastTrigger;

  String src(BuildContext context) {
    return "$_src"
        "${isThemeIndependent ? "" : Theme.of(context).brightness == Brightness.light ? "_light" : "_dark"}"
        ".riv";
  }

  bool get isActive =>
      _lastTrigger != null &&
      DateTime.now().difference(_lastTrigger!) <= duration;

  U get state => input.value;

  bool changeState() {
    return true;
  }

  void getRiveInputBool(Artboard artBoard) {
    StateMachineController? controller = StateMachineController.fromArtboard(
      artBoard,
      stateMachineName,
    );
    artBoard.addController(controller!);
    input = controller.findInput<U>(inputName) as T;
  }
}
