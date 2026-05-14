import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_a_config.dart';
import 'screens/fitness_dashboard_screen.dart';

class AppA extends StatelessWidget {
  const AppA({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => AuthProvider(
        webClientId:
        fitnessConfig
            .webClientId,
      ),

      child: MaterialApp(
        debugShowCheckedModeBanner:
        false,

        theme: AppTheme.buildTheme(
          fitnessConfig,
        ),

        home: LoginScreen(
          config: fitnessConfig,

          nextScreen:
          const FitnessDashboardScreen(),
        ),
      ),
    );
  }
}