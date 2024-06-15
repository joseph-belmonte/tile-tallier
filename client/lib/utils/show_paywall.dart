import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../features/manage_purchases/presentation/screens/paywall.dart';
import '../features/manage_purchases/presentation/widgets/dismiss_dialog.dart';

/// Shows the paywall to the user.
Future<void> showPaywall(BuildContext context) async {
  Offerings? offerings;
  try {
    offerings = await Purchases.getOfferings();
  } on PlatformException catch (e) {
    if (context.mounted) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => ShowDialogToDismiss(
          title: 'Error',
          content: e.message ?? 'Unknown error',
          buttonText: 'OK',
        ),
      );
    } else {
      print('Error: $e');
    }
  }

  if (offerings == null || offerings.current == null) {
    if (context.mounted) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => ShowDialogToDismiss(
          title: 'No Offerings',
          content: 'No offerings are available at the moment.',
          buttonText: 'OK',
        ),
      );
    }
  } else {
    if (context.mounted) {
      await showModalBottomSheet(
        useRootNavigator: true,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return Paywall(offering: offerings!.current!);
        },
      );
    }
  }
}
