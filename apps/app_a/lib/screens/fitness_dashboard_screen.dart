import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_a_config.dart';
import '../providers/member_provider.dart';
import '../widgets/member_list_item.dart';
import 'add_member_screen.dart';
import 'member_detail_screen.dart';

class FitnessDashboardScreen extends StatelessWidget {
  const FitnessDashboardScreen({super.key});

  void _openAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: context.read<MemberProvider>(),
          child: const AddMemberScreen(),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    String id,
    String name,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete member?'),
        content: Text('"$name" will be permanently removed.'),
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
      await context.read<MemberProvider>().delete(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MemberProvider>();

    return BaseDashboardScreen(
      config: fitnessConfig,
      loginScreen: LoginScreen(
        config: fitnessConfig,
        nextScreen: const FitnessDashboardScreen(),
      ),
      onAdd: () => _openAdd(context),
      child: Column(
        children: [
          DashboardCard(
            title: 'Total Members',
            value: '${provider.count}',
            icon: Icons.people,
            color: fitnessConfig.primaryColor,
          ),
          const SizedBox(height: 20),
          DashboardCard(
            title: 'Active Members',
            value: '${provider.activeCount}',
            icon: Icons.fitness_center,
            color: fitnessConfig.secondaryColor,
          ),
          const SizedBox(height: 30),
          Expanded(child: _buildBody(context, provider)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, MemberProvider provider) {
    if (provider.isLoading && provider.members.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null && provider.members.isEmpty) {
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

    if (provider.members.isEmpty) {
      return const Center(child: Text('No members yet. Tap + to add.'));
    }

    return ListView.builder(
      itemCount: provider.members.length,
      itemBuilder: (_, i) {
        final m = provider.members[i];
        return MemberListItem(
          member: m,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MemberDetailScreen(member: m),
            ),
          ),
          onDelete: () => _confirmDelete(context, m.id, m.name),
        );
      },
    );
  }
}
