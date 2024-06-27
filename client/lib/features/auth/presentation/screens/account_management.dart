import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/auth_provider.dart';

/// A screen for managing the user's account.
class AccountManagementScreen extends ConsumerStatefulWidget {
  /// Creates a new [AccountManagementScreen] instance.
  const AccountManagementScreen({super.key});

  @override
  ConsumerState<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState
    extends ConsumerState<AccountManagementScreen> {
  Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
    await ref.read(authProvider.notifier).deleteAccount();

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    await ref.read(authProvider.notifier).logout();

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Account Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('isAuthenticated:'),
            ListTile(
              title: Text('${authState.isAuthenticated}'),
            ),
            SizedBox(height: 20),
            Text('Email:'),
            ListTile(
              title: Text('${authState.user?.email}'),
            ),
            SizedBox(height: 20),
            Text(
              'Subscription:',
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => _deleteAccount(context, ref),
                child: Text('Delete Account'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => _logout(context, ref),
                child: Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
