import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/toast.dart';
import '../../../manage_purchases/application/providers/customer_info_provider.dart';

/// A tile that allows the user to restore purchases
class RestorePurchaseTile extends ConsumerWidget {
  /// Creates a new [RestorePurchaseTile] instance.
  const RestorePurchaseTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Restore Purchases'),
      subtitle: const Text(
        'Restore your purchases if you have reinstalled the app',
      ),
      leading: const Icon(Icons.restore),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () async {
        try {
          await ref.read(customerInfoProvider.notifier).restorePurchases();
          if (context.mounted) {
            ToastService.message(
              context,
              'Purchases restored successfully',
            );
          }
        } catch (e) {
          if (context.mounted) {
            ToastService.error(
              context,
              'Error restoring purchases: $e',
            );
          }
        }
      },
    );
  }
}
