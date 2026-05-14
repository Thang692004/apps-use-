import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../config/app_a_config.dart';

class FitnessDashboardScreen
    extends StatelessWidget {
  const FitnessDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDashboardScreen(
      config: fitnessConfig,

      loginScreen: LoginScreen(
        config: fitnessConfig,

        nextScreen:
        const FitnessDashboardScreen(),
      ),

      onAdd: () {},

      child: Column(
        children: [
          DashboardCard(
            title: 'Total Members',
            value: '128',
            icon: Icons.people,
            color:
            fitnessConfig.primaryColor,
          ),

          const SizedBox(height: 20),

          DashboardCard(
            title: 'Active PT Clients',
            value: '34',
            icon: Icons.fitness_center,
            color:
            fitnessConfig.secondaryColor,
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
                      fitnessConfig
                          .primaryColor,

                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),

                    title: Text(
                      'Member ${index + 1}',
                    ),

                    subtitle: const Text(
                      'Premium Package',
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