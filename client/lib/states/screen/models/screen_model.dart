part of screen_provider;

class ScreenModel {
  bool isMenuOpen;
  late TabController _controller;
  ScreenModel({
    this.isMenuOpen = false,
    TabController? controller,
  }) {
    if (controller != null) {
      _controller = controller;
    }
  }

  int get screen => _controller.index;

  ScreenModel copyWith({
    bool? isMenuOpen,
    TabController? controller,
  }) {
    return ScreenModel(
      isMenuOpen: isMenuOpen ?? this.isMenuOpen,
      controller: controller ?? _controller,
    );
  }
}
