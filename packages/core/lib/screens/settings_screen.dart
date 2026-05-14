import 'package:flutter/material.dart';
import '../config/app_config.dart';

class SettingsScreen extends StatelessWidget {
  final AppConfig config;

  const SettingsScreen({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.backgroundColor,
      appBar: AppBar(
        backgroundColor: config.primaryColor,
        title: const Text('Settings'),
      ),
      body: Center(
        child: Text(
          'Settings of ${config.appName}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}