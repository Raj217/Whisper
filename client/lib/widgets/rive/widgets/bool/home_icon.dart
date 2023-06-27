part of rive_widgets;

class HomeIcon extends ConsumerStatefulWidget {
  final double height;
  final double width;
  final void Function(RiveBase)? onInit;
  const HomeIcon({
    Key? key,
    this.height = 60,
    this.width = 60,
    this.onInit,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeIconState();
}

class _HomeIconState extends ConsumerState<HomeIcon> {
  late final RiveHomeIcon homeIcon;
  @override
  void initState() {
    super.initState();
    homeIcon = RiveHomeIcon();
  }

  @override
  Widget build(BuildContext context) {
    return RiveWidgetBase(
      height: widget.height,
      width: widget.width,
      addBG: false,
      controller: homeIcon,
      onInit: widget.onInit,
    );
  }
}

class RiveHomeIcon extends RiveBool {
  RiveHomeIcon()
      : super(
          src: RivePath.settings,
          artBoard: "HOME",
          duration: const Duration(seconds: 1),
          inputName: "active",
          isThemeIndependent: true,
          reverseBackAfterTransition: true,
          stateMachineName: "HOME_interactivity",
        );
}
