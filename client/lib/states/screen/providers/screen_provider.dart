part of screen_provider;

final screenProvider = StateNotifierProvider<ScreenNotifier, int>((ref) {
  return ScreenNotifier();
});

class ScreenNotifier extends StateNotifier<int> {
  ScreenNotifier() : super(0);

  int get screen => state;
  set screen(int newScreen) => state = newScreen;
}
