part of rive_widgets;

class ThemeToggle extends StatefulWidget {
  final double height;
  final double width;
  final void Function(bool) onStateChange;
  final bool? isDarkTheme;
  const ThemeToggle({
    Key? key,
    this.height = 60,
    this.width = 60,
    this.isDarkTheme,
    required this.onStateChange,
  }) : super(key: key);

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  late final RiveThemeToggle themeToggle;
  @override
  void initState() {
    super.initState();
    themeToggle = RiveThemeToggle(isLightMode: widget.isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    return RiveWidgetBase(
      height: widget.height,
      width: widget.width,
      addBG: false,
      onStateChange: widget.onStateChange,
      onInit: () {
        if (widget.isDarkTheme == true) themeToggle.changeState();
      },
      controller: themeToggle,
    );
  }
}

class RiveThemeToggle extends RiveBool {
  RiveThemeToggle({bool? isLightMode})
      : super(
          src: RivePath().themeToggle,
          artBoard: "THEME",
          duration: const Duration(seconds: 1),
          inputName: "isDark",
          isThemeIndependent: true,
          reverseBackAfterTransition: false,
          stateMachineName: "THEME_Interactivity",
        );
}
