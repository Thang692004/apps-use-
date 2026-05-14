import 'package:flutter/material.dart';

import '../config/app_a_config.dart';
import '../models/member_model.dart';

class MemberListItem extends StatelessWidget {
  final MemberModel member;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const MemberListItem({
    super.key,
    required this.member,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final expired = member.isExpired;

    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor:
              expired ? Colors.grey : fitnessConfig.primaryColor,
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          member.name.isEmpty ? '(no name)' : member.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${member.packageName} • PT: ${member.pt.isEmpty ? "-" : member.pt}',
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
