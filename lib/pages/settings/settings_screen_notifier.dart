import 'package:flutter/material.dart';

class SettingsScreenNotifier extends ChangeNotifier {
  bool _isDarkModeEnabled = true;
  String _applicationLanguage = 'en';

  get isDarkModeEnabled => _isDarkModeEnabled;
  void toggleApplicationTheme(bool darkModeEnabled) {
    _isDarkModeEnabled = darkModeEnabled;
    notifyListeners();
  }


  get applicationLanguage => _applicationLanguage;
  void updateApplicationLanguage(String countryCode) {
    _applicationLanguage = countryCode;
    notifyListeners();
  }
}