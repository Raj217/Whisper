part of rive_widgets;

class SettingsIcon extends ConsumerStatefulWidget {
  final double height;
  final double width;
  const SettingsIcon({
    Key? key,
    this.height = 60,
    this.width = 60,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<SettingsIcon> {
  late final RiveSettingsIcon settings;
  @override
  void initState() {
    super.initState();
    settings = RiveSettingsIcon();
  }

  @override
  Widget build(BuildContext context) {
    return RiveWidgetBase(
      height: widget.height,
      width: widget.width,
      addBG: false,
      onStateChange: (_) {},
      onInit: () {},
      controller: settings,
    );
  }
}

class RiveSettingsIcon extends RiveBool {
  RiveSettingsIcon()
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
