import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  static SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }
}
