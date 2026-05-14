import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_b_config.dart';
import '../providers/order_provider.dart';
import '../widgets/order_list_item.dart';
import 'add_order_screen.dart';
import 'order_detail_screen.dart';

class FoodDashboardScreen extends StatelessWidget {
  const FoodDashboardScreen({super.key});

  void _openAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: context.read<OrderProvider>(),
          child: const AddOrderScreen(),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    String id,
    String foodName,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete order?'),
        content: Text('"$foodName" will be permanently removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      await context.read<OrderProvider>().delete(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();

    return BaseDashboardScreen(
      config: foodConfig,
      loginScreen: LoginScreen(
        config: foodConfig,
        nextScreen: const FoodDashboardScreen(),
      ),
      onAdd: () => _openAdd(context),
      child: Column(
        children: [
          DashboardCard(
            title: 'Total Orders',
            value: '${provider.count}',
            icon: Icons.delivery_dining,
            color: foodConfig.primaryColor,
          ),
          const SizedBox(height: 20),
          DashboardCard(
            title: 'Customers Served',
            value:
                '${provider.orders.map((o) => o.customerPhone).toSet().length}',
            icon: Icons.people,
            color: foodConfig.secondaryColor,
          ),
          const SizedBox(height: 30),
          Expanded(child: _buildBody(context, provider)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, OrderProvider provider) {
    if (provider.isLoading && provider.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null && provider.orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Error: ${provider.error}',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (provider.orders.isEmpty) {
      return const Center(child: Text('No orders yet. Tap + to add.'));
    }

    return ListView.builder(
      itemCount: provider.orders.length,
      itemBuilder: (_, i) {
        final o = provider.orders[i];
        return OrderListItem(
          order: o,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderDetailScreen(order: o),
            ),
          ),
          onDelete: () => _confirmDelete(context, o.id, o.foodName),
        );
      },
    );
  }
}
