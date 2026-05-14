import 'package:flutter/material.dart';

class AppConfig {
  final String appName;
  final String slogan;
  final String logoPath;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final String webClientId;
  final bool isFitnessApp;

  const AppConfig({
    required this.appName,
    required this.slogan,
    required this.logoPath,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.isFitnessApp,
    required this.webClientId,
  });
}