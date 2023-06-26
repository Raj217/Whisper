part of rive_widgets;

class ThemeToggle extends ConsumerStatefulWidget {
  final double height;
  final double width;
  const ThemeToggle({
    Key? key,
    this.height = 60,
    this.width = 60,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ThemeToggleState();
}

class _ThemeToggleState extends ConsumerState<ThemeToggle> {
  late final RiveThemeToggle themeToggle;
  @override
  void initState() {
    super.initState();
    themeToggle = RiveThemeToggle();
  }

  @override
  Widget build(BuildContext context) {
    return RiveWidgetBase(
      height: widget.height,
      width: widget.width,
      addBG: false,
      onStateChange: (bool isDarkTheme) {
        ref.read(themeProvider.notifier).changeTheme(isDarkTheme);
      },
      onInit: () {
        bool isDarkTheme =
            ref.read(themeProvider.notifier).isDarkTheme(context);
        if (isDarkTheme == true) themeToggle.changeState();
      },
      controller: themeToggle,
    );
  }
}

class RiveThemeToggle extends RiveBool {
  RiveThemeToggle()
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
