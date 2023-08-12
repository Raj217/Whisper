part of rive_widgets;

class FilterMenu extends RiveWidgetBase {
  const FilterMenu._({
    super.key,
    super.height = 30,
    super.width = 30,
    super.onStateChange,
    super.onInit,
    required super.controller,
  });

  factory FilterMenu(
      {Key? key,
      double height = 30,
      double width = 30,
      void Function(bool)? onStateChange,
      void Function()? onInit,
      RiveController? controller}) {
    controller ??= RiveFilterMenuController();
    return FilterMenu._(
      key: key,
      height: height,
      width: width,
      onStateChange: onStateChange,
      onInit: onInit,
      controller: controller,
    );
  }
}

class RiveFilterMenuController extends RiveBoolController {
  RiveFilterMenuController()
      : super(
          src: RivePath.filterMenu,
          artBoard: "New Artboard",
          stateMachineName: "State Machine 1",
          inputName: "Hover/Press",
          reverseBackAfterTransition: false,
          duration: const Duration(seconds: 1),
          isThemeIndependent: false,
        );
}
