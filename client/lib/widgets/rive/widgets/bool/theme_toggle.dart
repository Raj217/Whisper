part of rive_widgets;

class ThemeToggle extends StatefulWidget {
  final double height;
  final double width;
  final void Function(bool) onStateChange;
  const ThemeToggle({
    Key? key,
    this.height = 60,
    this.width = 60,
    required this.onStateChange,
  }) : super(key: key);

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  final RiveThemeToggle themeToggle = RiveThemeToggle();
  @override
  Widget build(BuildContext context) {
    return RiveWidgetBase(
      height: widget.height,
      width: widget.width,
      addBG: false,
      onStateChange: widget.onStateChange,
      controller: themeToggle,
    );
  }
}

class RiveThemeToggle extends RiveBool {
  RiveThemeToggle()
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
