part of rive_widgets;

class SettingsIcon extends RiveWidgetBase {
  const SettingsIcon._({
    super.key,
    super.height,
    super.width,
    super.onInit,
    required super.controller,
    super.addBG,
  });

  factory SettingsIcon({
    Key? key,
    double height = 60,
    double width = 60,
    void Function()? onInit,
    RiveController? controller,
  }) {
    controller ??= RiveSettingsIconController();
    return SettingsIcon._(
      key: key,
      height: height,
      width: width,
      onInit: onInit,
      controller: controller,
      addBG: false,
    );
  }
}

class RiveSettingsIconController extends RiveBoolController {
  RiveSettingsIconController()
      : super(
          src: RivePath.settings,
          artBoard: "SETTINGS",
          duration: const Duration(seconds: 1),
          inputName: "active",
          isThemeIndependent: true,
          reverseBackAfterTransition: true,
          stateMachineName: "SETTINGS_Interactivity",
        );
}
