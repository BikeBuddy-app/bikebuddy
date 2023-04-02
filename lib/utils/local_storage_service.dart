import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static bool? readBool(String key) => instance.getBool(key);

  static Future<bool> writeBool(String key, bool value) =>
      instance.setBool(key, value);

  static String? readString(String key) => instance.getString(key);

  static Future<bool> writeString(String key, String value) =>
      instance.setString(key, value);
}
