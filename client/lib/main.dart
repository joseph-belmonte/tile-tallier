import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/theme_wrapper.dart';
import 'utils/errors.dart';
import 'utils/start/app_initializations.dart';

/// The key for the navigator.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  BindingBase.debugZoneErrorsAreFatal = true; // Make zone errors fatal

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final settingsContainer = ProviderContainer();

    await initializeApp(settingsContainer);

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      handleError(details.exceptionAsString(), details.stack.toString());
    };

    runApp(
      UncontrolledProviderScope(
        container: settingsContainer,
        child: ProviderScope(
          child: const ThemeWrapper(),
        ),
      ),
    );
  }, (error, stack) {
    handleError(error.toString(), stack.toString());
  });
}
