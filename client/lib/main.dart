import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/theme_wrapper.dart';
import 'utils/start/app_initializations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsContainer = ProviderContainer();

  await initializeApp(settingsContainer);

  runApp(
    UncontrolledProviderScope(
      container: settingsContainer,
      child: ProviderScope(
        child: const ThemeWrapper(),
      ),
    ),
  );
}
