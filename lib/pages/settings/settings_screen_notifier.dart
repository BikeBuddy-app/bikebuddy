import 'package:bike_buddy/constants/default_values.dart' as default_value;
import 'package:bike_buddy/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class SettingsScreenNotifier extends ChangeNotifier {
  bool _isDarkModeEnabled = default_value.darkMode;
  String _applicationLanguage = default_value.language;
  String _distanceUnit = default_value.distanceUnit;

  SettingsScreenNotifier() {
    loadSettingsFromMemory();
  }

  get isDarkModeEnabled => _isDarkModeEnabled;
  void toggleApplicationTheme(bool darkModeEnabled) {
    _isDarkModeEnabled = darkModeEnabled;
    SharedPrefs.setDarkModePref(darkModeEnabled);
    notifyListeners();
  }

  get applicationLanguage => _applicationLanguage;
  void updateApplicationLanguage(String countryCode) {
    _applicationLanguage = countryCode;
    SharedPrefs.setLanguage(countryCode);
    notifyListeners();
  }

  get distanceUnit => _distanceUnit;
  void updateDistanceUnit(String unit) {
    _distanceUnit = unit;
    SharedPrefs.setDistanceUnitsPref(unit);
    notifyListeners();
  }

  void loadSettingsFromMemory() {
    _isDarkModeEnabled = SharedPrefs.getDarkModePref() ?? default_value.darkMode;
    _applicationLanguage = SharedPrefs.getLanguagePref() ?? default_value.language;
    _distanceUnit = SharedPrefs.getDistanceUnitsPref() ?? default_value.distanceUnit;

  }
}
