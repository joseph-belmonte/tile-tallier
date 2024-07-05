import 'package:flutter/material.dart';

import '../../domain/models/game.dart';
import '../../domain/models/game_player.dart';

import '../widgets/gameplay/historical_play.dart';

/// A screen that displays the play summary for a player.
class PlayerResultsScreen extends StatelessWidget {
  /// Creates a new [PlayerResultsScreen] instance.
  const PlayerResultsScreen({
    required Game game,
    required GamePlayer player,
    super.key,
  })  : _game = game,
        _player = player;

  final Game _game;
  final GamePlayer _player;

  @override
  Widget build(BuildContext context) {
    final plays =
        _game.plays.where((play) => play.playerId == _player.id).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('${_player.name}\'s Plays'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: plays.length,
                itemBuilder: (_, i) {
                  final play = plays[i];
                  return HistoricalPlay(i, player: _player, play: play);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
