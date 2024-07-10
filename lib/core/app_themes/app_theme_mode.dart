import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_theme.dart';

class LightThemeMode extends AppTheme {
  @override
  ColorScheme get colorScheme => ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        surface: surface,
        onSurface: onSurface,
      );

  @override
  Color get error => Colors.red;

  @override
  Color get onError => Colors.white;

  @override
  Color get onPrimary => Colors.black;

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get onSurface => Colors.white;

  @override
  Color get primary => Colors.white;

  @override
  Color get secondary => Colors.black;

  @override
  Color get surface => Colors.pink;
}

class DarkThemeMode extends AppTheme {
  @override
  ColorScheme get colorScheme => ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        surface: surface,
        onSurface: onSurface,
      );

  @override
  Color get error => Colors.red;

  @override
  Color get onError => Colors.white;

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get onSecondary => Colors.black;

  @override
  Color get onSurface => Colors.white;

  @override
  Color get primary => Colors.black;

  @override
  Color get secondary => Colors.white;

  @override
  Color get surface => Colors.black;
}
