import 'package:bike_buddy/constants/default_values.dart' as default_value;
import 'package:bike_buddy/constants/general_constants.dart' as constants;
import 'package:bike_buddy/utils/local_storage_service.dart';
import 'package:flutter/material.dart';

class SettingsManager extends ChangeNotifier {
  // keys used to store values in local memory
  static const _darkModeKey = 'isDarkModeEnabled';
  static const _languageKey = 'language';
  static const _distanceUnitKey = 'distanceUnits';
  static const _riderWeightKey = 'riderWeight';

  final String _weightUnit = constants.SUPPORTED_WEIGHT_UNITS[0];

  bool _isDarkModeEnabled = default_value.darkMode;
  String _applicationLanguage = default_value.language;
  String _distanceUnit = default_value.distanceUnit;
  int _riderWeight = default_value.riderWeight;

  SettingsManager() {
    loadSettingsFromMemory();
  }

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  set applicationTheme(bool darkModeValue) {
    _isDarkModeEnabled = darkModeValue;
    LocalStorageService.writeBool(_darkModeKey, darkModeValue);
    notifyListeners();
  }

  String get applicationLanguage => _applicationLanguage;

  set applicationLanguage(String countryCode) {
    _applicationLanguage = countryCode;
    LocalStorageService.writeString(_languageKey, countryCode);
    notifyListeners();
  }

  String get distanceUnit => _distanceUnit;

  set distanceUnit(String unit) {
    _distanceUnit = unit;
    LocalStorageService.writeString(_distanceUnitKey, unit);
    notifyListeners();
  }

  String get weightUnit => _weightUnit;

  int get riderWeight => _riderWeight;

  set riderWeight(int weight) {
    _riderWeight = weight;
    LocalStorageService.writeInt(_riderWeightKey, weight);
    notifyListeners();
  }

  void loadSettingsFromMemory() {
    _isDarkModeEnabled =
        LocalStorageService.readBool(_darkModeKey) ?? default_value.darkMode;
    _applicationLanguage =
        LocalStorageService.readString(_languageKey) ?? default_value.language;
    _distanceUnit = LocalStorageService.readString(_distanceUnitKey) ??
        default_value.distanceUnit;
  }
}
