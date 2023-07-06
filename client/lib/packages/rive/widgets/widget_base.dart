part of rive_widgets;

class RiveWidgetBase extends StatefulWidget {
  final bool addBG;
  final double width;
  final double height;
  final void Function()? onInit;
  final RiveController controller;
  final void Function(bool)? onStateChange;
  const RiveWidgetBase({
    Key? key,
    this.height = 30,
    this.width = 30,
    this.addBG = true,
    this.onInit,
    this.onStateChange,
    required this.controller,
  }) : super(key: key);
  @override
  State createState() => _RiveWidgetBaseState();

  RiveWidgetBase copyWith({
    bool? addBG,
    double? width,
    double? height,
    void Function()? onInit,
    RiveController? controller,
    void Function(bool)? onStateChange,
  }) {
    return RiveWidgetBase(
      addBG: addBG ?? this.addBG,
      width: width ?? this.width,
      height: height ?? this.height,
      onInit: onInit ?? this.onInit,
      controller: controller ?? this.controller,
      onStateChange: onStateChange ?? this.onStateChange,
    );
  }
}

class _RiveWidgetBaseState extends State<RiveWidgetBase> {
  late RiveController controller;
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(
      height: widget.height,
      width: widget.width,
      child: RiveAnimation.asset(
        widget.controller.src(context),
        artboard: widget.controller.artBoard,
        onInit: (Artboard artBoard) {
          controller.getRiveInputBool(artBoard);
          if (widget.onInit != null) widget.onInit!();
        },
      ),
    );
    void onPressed() {
      if (widget.onStateChange != null) {
        if (controller.changeState()) {
          widget.onStateChange!(controller.state);
        }
      }
    }

    return widget.onStateChange == null
        ? child
        : widget.addBG
            ? IconButton(
                onPressed: onPressed,
                icon: child,
              )
            : GestureDetector(
                onTap: onPressed,
                child: child,
              );
  }
}
