import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'active_game.dart';
import 'material_wrapper.dart';
import 'writing_zone.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ActiveGame>(
          create: (context) => ActiveGame(),
        ),
        ChangeNotifierProvider<CurrentPlayState>(
          create: (context) => CurrentPlayState(),
        ),
        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
        ),
      ],
      child: MaterialWrapper(),
    ),
  );
}
