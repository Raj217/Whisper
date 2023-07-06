part of rive_widgets;

class HamburgerMenu extends RiveWidgetBase {
  const HamburgerMenu._({
    super.key,
    super.height = 30,
    super.width = 30,
    super.onStateChange,
    super.onInit,
    required super.controller,
  });

  factory HamburgerMenu({
    Key? key,
    double width = 30,
    double height = 30,
    void Function(bool)? onStateChange,
    void Function()? onInit,
    RiveController? controller,
  }) {
    controller ??= RiveHamburgerMenuController();
    return HamburgerMenu._(
      key: key,
      width: width,
      height: height,
      onStateChange: onStateChange,
      onInit: onInit,
      controller: controller,
    );
  }
}

class RiveHamburgerMenuController extends RiveTriggerController {
  RiveHamburgerMenuController()
      : super(
          src: RivePath.hamburgerMenu,
          artBoard: "HAMBURGER",
          stateMachineName: "HAMBURGER_Interactivity",
          inputName: "Trigger",
          duration: const Duration(seconds: 1),
          isThemeIndependent: false,
        );
}
