import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/active_play.dart';
import 'keyboard.dart';
import 'scrabble_tile.dart';

class WritingZone extends StatefulWidget {
  const WritingZone({super.key});

  @override
  State<WritingZone> createState() => _WritingZoneState();
}

class _WritingZoneState extends State<WritingZone> {
  @override
  Widget build(BuildContext context) {
    var activePlay = Provider.of<ActivePlay>(context, listen: false);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () => activePlay.playWord(context),
            label: const Text('Add word'),
          ),
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () => activePlay.startTurn(context),
            label: const Text('End turn'),
          ),
          Consumer<ActivePlay>(
            builder: (context, value, child) => ScrabbleWordWidget(
              activePlay.playedWord,
              interactive: true,
            ),
          ),
          const Keyboard(),
        ],
      ),
    );
  }
}
