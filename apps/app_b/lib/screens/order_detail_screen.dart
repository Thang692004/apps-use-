import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(order.foodName)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _section('Customer'),
          _row(Icons.person, 'Name', order.customerName),
          _row(Icons.phone, 'Phone', order.customerPhone),
          _section('Food'),
          _row(Icons.fastfood, 'Item', order.foodName),
          _section('Address'),
          _row(Icons.store, 'From', order.addressFrom),
          _row(Icons.location_on, 'To', order.addressTo),
          _section('Shipper'),
          _row(Icons.delivery_dining, 'Name', order.shiperName),
          _row(Icons.phone_iphone, 'Phone', order.shiperPhone),
        ],
      ),
    );
  }

  Widget _section(String label) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 4),
    child: Text(
      label,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );

  Widget _row(IconData icon, String label, String value) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(
          value.isEmpty ? '-' : value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
