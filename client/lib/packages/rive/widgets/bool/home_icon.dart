part of rive_widgets;

class HomeIcon extends RiveWidgetBase {
  const HomeIcon._({
    super.key,
    super.addBG,
    super.onInit,
    super.width = 60,
    super.height = 60,
    required super.controller,
  });

  factory HomeIcon({
    Key? key,
    double height = 60,
    double width = 60,
    void Function()? onInit,
    RiveController? controller,
  }) {
    controller ??= RiveHomeIconController();
    return HomeIcon._(
      key: key,
      height: height,
      width: width,
      onInit: onInit,
      controller: controller,
      addBG: false,
    );
  }
}

class RiveHomeIconController extends RiveBoolController {
  RiveHomeIconController()
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
