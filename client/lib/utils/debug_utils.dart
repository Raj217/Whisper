class DebugUtils {
  static Future<Duration> calcDuration(Function func) async {
    DateTime startTime = DateTime.now();
    await func();
    return DateTime.now().difference(startTime);
  }
}
