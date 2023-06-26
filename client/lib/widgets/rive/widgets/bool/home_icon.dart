part of rive_widgets;

class HomeIcon extends ConsumerStatefulWidget {
  final double height;
  final double width;
  const HomeIcon({
    Key? key,
    this.height = 60,
    this.width = 60,
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
      onStateChange: (_) {},
      onInit: () {},
      controller: homeIcon,
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
