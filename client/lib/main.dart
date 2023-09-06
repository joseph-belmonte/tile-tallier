import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'active_game.dart';
import 'app_state.dart';
import 'material_wrapper.dart';
import 'writing_zone.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ActiveGame>(create: (_) => ActiveGame()),
        ChangeNotifierProvider<CurrentPlayState>(create: (_) => CurrentPlayState()),
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
      ],
      child: MaterialWrapper(),
    ),
  );
}
