import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // keys used to store values in local memory
  static const _darkModeKey = 'isDarkModeEnabled';
  static const _languageKey = 'language';
  static const _distanceUnitsKey = 'distanceUnits';

  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static bool? getDarkModePref() => instance.getBool(_darkModeKey);

  static Future<bool> setDarkModePref(bool value) => instance.setBool(_darkModeKey, value);

  static String? getLanguagePref() => instance.getString(_languageKey);

  static Future<bool> setLanguage(String value) => instance.setString(_languageKey, value);

  static String? getDistanceUnitsPref() => instance.getString(_distanceUnitsKey);

  static Future<bool> setDistanceUnitsPref(String value) => instance.setString(_distanceUnitsKey, value);
}
