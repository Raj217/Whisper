part of rive_widgets;

class RiveHamburgerMenu extends RiveTrigger {
  RiveHamburgerMenu()
      : super(
          src: "assets/rive/hamburger_menu_light.riv",
          artBoard: "HAMBURGER",
          stateMachineName: "HAMBURGER_Interactivity",
          inputName: "Trigger",
          duration: const Duration(seconds: 1),
        );
}

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
    return IconButton(
      onPressed: () {
        bool currentState = hamburgerMenu.isActive;
        bool nextState = hamburgerMenu.changeSMIBoolState();
        if (currentState != nextState) {
          widget.onStateChange(nextState);
        }
      },
      icon: SizedBox(
        height: widget.height,
        width: widget.width,
        child: RiveAnimation.asset(
          hamburgerMenu.src,
          artboard: hamburgerMenu.artBoard,
          onInit: (Artboard artBoard) {
            hamburgerMenu.getRiveInputBool(artBoard);
          },
        ),
      ),
    );
  }
}
