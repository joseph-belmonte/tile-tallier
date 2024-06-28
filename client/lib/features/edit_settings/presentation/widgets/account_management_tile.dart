import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/application/providers/auth_provider.dart';
import '../../../auth/presentation/screens/account_management.dart';
import '../../../auth/presentation/screens/auth_screen.dart';

class AccountManagementTile extends ConsumerWidget {
  const AccountManagementTile({super.key});

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return ListTile(
      title: Text('Account Management'),
      subtitle: authState.isAuthenticated
          ? Text('Manage your account settings')
          : Text('Sign in to manage your account settings'),
      leading: Icon(Icons.account_circle),
      trailing: Icon(Icons.arrow_forward_sharp),
      onTap: () {
        if (authState.isAuthenticated) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AccountManagementScreen(),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AuthScreen()),
          );
        }
      },
    );
  }
}
