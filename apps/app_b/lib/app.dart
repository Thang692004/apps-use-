import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_b_config.dart';
import 'providers/order_provider.dart';
import 'screens/food_dashboard_screen.dart';

class AppB extends StatelessWidget {
  const AppB({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            webClientId: foodConfig.webClientId,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.buildTheme(foodConfig),
        home: LoginScreen(
          config: foodConfig,
          nextScreen: const FoodDashboardScreen(),
        ),
      ),
    );
  }
}
