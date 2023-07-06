part of screen_provider;

final screenProvider =
    StateNotifierProvider<ScreenNotifier, ScreenModel>((ref) {
  return ScreenNotifier();
});

class ScreenNotifier extends StateNotifier<ScreenModel> {
  ScreenNotifier() : super(ScreenModel());

  set controller(TabController controller) => state._controller = controller;

  bool get isMenuOpen => state.isMenuOpen;
  set isMenuOpen(bool val) => state = state.copyWith(isMenuOpen: val);

  int get screen => state._controller.index;
  set screen(int newScreen) {
    state._controller.index = newScreen;
  }
}
