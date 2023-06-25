import 'package:flutter/material.dart';

TextTheme kBBTextTheme = const TextTheme(
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.normal,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
);

ThemeData kBBLightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 255, 183, 77),
    onPrimary: Colors.black,
    primaryContainer: Color.fromRGBO(224, 224, 224, 1),
    secondary: Colors.grey,
    onSecondary: Colors.black,
    tertiary: Color.fromARGB(220, 255, 203, 97),
    onTertiary: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.grey,
    onSurface: Colors.black,
  ),
  textTheme: kBBTextTheme.apply(displayColor: Colors.black, bodyColor: Colors.black),
);

ThemeData kBBDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 66, 66, 66),
    onPrimary: Colors.white,
    primaryContainer: Color.fromARGB(255, 55, 55, 55),
    secondary: Color.fromARGB(255, 204, 195, 216),
    onSecondary: Colors.black,
    tertiary: Color.fromARGB(255, 151, 115, 63),
    onTertiary: Colors.white,
    background: Color.fromARGB(255, 49, 48, 49),
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Color.fromARGB(255, 28, 27, 31),
    onSurface: Colors.white,
  ),
  textTheme: kBBTextTheme.apply(displayColor: Colors.white, bodyColor: Colors.white),
);
