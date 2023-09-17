import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'material_wrapper.dart';
import 'providers/active_game.dart';
import 'providers/active_play.dart';
import 'providers/app_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ActiveGame>(create: (_) => ActiveGame()),
        ChangeNotifierProvider<ActivePlay>(
          create: (context) {
            var game = Provider.of<ActiveGame>(context, listen: false);
            var activePlay = ActivePlay();
            activePlay.play = game.activeGame.currentPlay;
            return activePlay;
          },
        ),
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
      ],
      child: MaterialWrapper(),
    ),
  );
}
