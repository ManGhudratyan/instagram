import 'package:flutter/material.dart';

import 'app_theme_mode.dart';

abstract class AppTheme {
  static AppTheme themeOf(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? LightThemeMode()
        : DarkThemeMode();
  }

  Color get primary;
  Color get onPrimary;
  Color get secondary;
  Color get onSecondary;
  Color get error;
  Color get onError;
  Color get surface;
  Color get onSurface;
  ColorScheme get colorScheme;
}

class AppThemeData {
  AppThemeData({required this.context});

  final BuildContext context;

  ThemeData get lighTheme => ThemeData(
        colorScheme: LightThemeMode().colorScheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        useMaterial3: true,
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: DarkThemeMode().colorScheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        useMaterial3: true,
      );
}
