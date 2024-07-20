import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_theme.dart';

class DarkThemeMode extends AppTheme {
  @override
  Color get primaryColor => Color.fromARGB(255, 0, 0, 0);

  @override
  Color get error => Colors.redAccent;

  @override
  Color get onError => Colors.white70;

  @override
  Color get onPrimary => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get onSecondary =>  Colors.black;

  @override
  Color get onSurface => Colors.white;

  @override
  Color get secondary => Color.fromARGB(255, 255, 255, 255);

  @override
  Color get surface => Colors.black;

  @override
  ColorScheme get colorScheme => ColorScheme(
        brightness: Brightness.dark,
        primary: primaryColor,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        surface: surface,
        onSurface: onSurface,
      );
}

class LightThemeMode extends AppTheme {
  @override
  Color get primaryColor => Colors.white;

  @override
  Color get error => Colors.redAccent;

  @override
  Color get onError => Colors.white70;

  @override
  Color get onPrimary => Colors.black;

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get onSurface => Colors.black;

  @override
  Color get secondary => Colors.white;

  @override
  Color get surface => Colors.white;

  @override
  ColorScheme get colorScheme => ColorScheme(
        brightness: Brightness.dark,
        primary: primaryColor,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        surface: surface,
        onSurface: onSurface,
      );
}
