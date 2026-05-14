import 'package:flutter/material.dart';

import '../models/member_model.dart';

class MemberDetailScreen extends StatelessWidget {
  final MemberModel member;

  const MemberDetailScreen({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final expired = member.isExpired;
    final dateLabel =
        '${member.expiredDate.day}/${member.expiredDate.month}/${member.expiredDate.year}';

    return Scaffold(
      appBar: AppBar(title: Text(member.name)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _row(Icons.person, 'Name', member.name),
          _row(Icons.phone, 'Phone', member.phone),
          _row(Icons.card_membership, 'Package', member.packageName),
          _row(Icons.fitness_center, 'PT', member.pt),
          _row(
            Icons.event,
            'Expired',
            dateLabel,
            valueColor: expired ? Colors.red : Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _row(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(
          value.isEmpty ? '-' : value,
          style: TextStyle(
            fontSize: 16,
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
