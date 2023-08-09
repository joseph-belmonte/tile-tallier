import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_keyboard.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key, required this.title});
  final String title;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [Text("Top Row")]),
          WritingZone(),
        ],
      ),
    );
  }
}

class WritingZone extends StatefulWidget {
  const WritingZone({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _WritingZoneState();
  }
}

class _WritingZoneState extends State<WritingZone> {
  @override
  Widget build(BuildContext context) {
    final scrabbleKeyboardState = Provider.of<ScrabbleKeyboardState>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.pink,
              width: double.infinity,
              child: Text(scrabbleKeyboardState.typedText,
                  style: const TextStyle(fontSize: 20)),
            ),
            ScrabbleKeyboard(),
          ],
        ),
      ],
    );
  }
}
