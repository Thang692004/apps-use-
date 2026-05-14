import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../providers/auth_provider.dart';

class BaseDashboardScreen extends StatelessWidget {
  final AppConfig config;

  final Widget child;

  final Widget loginScreen;

  final VoidCallback? onAdd;

  const BaseDashboardScreen({
    super.key,
    required this.config,
    required this.child,
    required this.loginScreen,
    this.onAdd,
  });

  Future<void> _handleLogout(
      BuildContext context,
      ) async {
    final authProvider =
    context.read<AuthProvider>();

    await authProvider.logout();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => loginScreen,
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(config.appName),

        actions: [
          IconButton(
            onPressed: () =>
                _handleLogout(context),

            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: config.primaryColor,

        onPressed: onAdd,

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}