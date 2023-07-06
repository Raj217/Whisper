part of rive_widgets;

class ThemeToggle extends RiveWidgetBase {
  const ThemeToggle._({
    super.key,
    super.height,
    super.width,
    super.addBG,
    super.onInit,
    super.onStateChange,
    required super.controller,
  });

  factory ThemeToggle({
    Key? key,
    double width = 60,
    double height = 60,
    required WidgetRef ref,
    RiveController? controller,
    required BuildContext context,
    void Function()? onInit,
  }) {
    controller ??= RiveThemeToggleController();
    return ThemeToggle._(
      key: key,
      height: height,
      width: width,
      addBG: false,
      onStateChange: (bool isDarkTheme) {
        ref.read(themeProvider.notifier).changeTheme(isDarkTheme);
      },
      onInit: () {
        bool isDarkTheme =
            ref.read(themeProvider.notifier).isDarkTheme(context);
        if (isDarkTheme == true) controller!.changeState();
        if (onInit != null) onInit();
      },
      controller: controller,
    );
  }
}

class RiveThemeToggleController extends RiveBoolController {
  RiveThemeToggleController()
      : super(
          src: RivePath.themeToggle,
          artBoard: "THEME",
          duration: const Duration(seconds: 1),
          inputName: "isDark",
          isThemeIndependent: true,
          reverseBackAfterTransition: false,
          stateMachineName: "THEME_Interactivity",
        );
}
