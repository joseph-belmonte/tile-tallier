import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/material_wrapper.dart';
import 'providers/app_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
      ],
      child: MaterialWrapper(),
    ),
  );
}
