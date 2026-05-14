import 'package:flutter/material.dart';
import '../config/app_config.dart';

class DetailScreen extends StatelessWidget {
  final AppConfig config;

  const DetailScreen({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.backgroundColor,
      appBar: AppBar(
        backgroundColor: config.primaryColor,
        title: const Text('Detail Screen'),
      ),
      body: Center(
        child: Text(
          'This is Detail Screen of ${config.appName}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}