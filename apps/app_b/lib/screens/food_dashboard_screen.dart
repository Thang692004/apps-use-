import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../config/app_b_config.dart';

class FoodDashboardScreen
    extends StatelessWidget {
  const FoodDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDashboardScreen(
      config: foodConfig,

      loginScreen: LoginScreen(
        config: foodConfig,

        nextScreen:
        const FoodDashboardScreen(),
      ),

      onAdd: () {},

      child: Column(
        children: [
          DashboardCard(
            title: 'Total Orders',
            value: '532',
            icon: Icons.delivery_dining,
            color: foodConfig.primaryColor,
          ),

          const SizedBox(height: 20),

          DashboardCard(
            title: 'Delivering Orders',
            value: '48',
            icon: Icons.motorcycle,
            color:
            foodConfig.secondaryColor,
          ),

          const SizedBox(height: 30),

          Expanded(
            child: ListView.builder(
              itemCount: 10,

              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                      foodConfig
                          .primaryColor,

                      child: const Icon(
                        Icons.fastfood,
                        color: Colors.white,
                      ),
                    ),

                    title: Text(
                      'Order ${index + 1}',
                    ),

                    subtitle: const Text(
                      'Delivering...',
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}