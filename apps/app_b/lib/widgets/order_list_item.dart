import 'package:flutter/material.dart';

import '../config/app_b_config.dart';
import '../models/order_model.dart';

class OrderListItem extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const OrderListItem({
    super.key,
    required this.order,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: foodConfig.primaryColor,
          child: const Icon(Icons.fastfood, color: Colors.white),
        ),
        title: Text(
          order.foodName.isEmpty ? '(no food)' : order.foodName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${order.customerName} → ${order.addressTo}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.redAccent,
          onPressed: onDelete,
        ),
      ),
    );
  }
}
