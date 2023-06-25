part of rive_widgets;

class HamburgerMenu extends StatefulWidget {
  final double height;
  final double width;
  final void Function(bool) onStateChange;
  const HamburgerMenu({
    Key? key,
    this.height = 30,
    this.width = 30,
    required this.onStateChange,
  }) : super(key: key);

  @override
  State<HamburgerMenu> createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {
  final RiveHamburgerMenu hamburgerMenu = RiveHamburgerMenu();

  @override
  Widget build(BuildContext context) {
    return RiveWidgetBase(
      height: widget.height,
      width: widget.width,
      onStateChange: widget.onStateChange,
      controller: hamburgerMenu,
    );
  }
}

class RiveHamburgerMenu extends RiveTrigger {
  RiveHamburgerMenu()
      : super(
          src: RivePath().hamburgerMenu,
          artBoard: "HAMBURGER",
          stateMachineName: "HAMBURGER_Interactivity",
          inputName: "Trigger",
          duration: const Duration(seconds: 1),
          isThemeIndependent: false,
        );
}
