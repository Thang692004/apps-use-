import 'package:flutter/material.dart';

import '../config/app_config.dart';

class AppTheme {
  static ThemeData buildTheme(AppConfig config) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: config.backgroundColor,

      colorScheme: ColorScheme.fromSeed(
        seedColor: config.primaryColor,
        primary: config.primaryColor,
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: config.primaryColor,
        foregroundColor: Colors.white,
      ),

      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}