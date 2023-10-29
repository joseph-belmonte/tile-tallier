import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../providers/active_play.dart';
import '../providers/app_state.dart';

// TODO: refactor the word widget to accept a plain string and display it as a word, no tap, no multiplier, provider

/// A widget that displays a word as a list of ScrabbleTile widgets.
class ScrabbleWordWidget extends StatefulWidget {
  final PlayedWord word;
  final bool interactive;

  const ScrabbleWordWidget(this.word, {required this.interactive, super.key});

  @override
  ScrabbleWordWidgetState createState() => ScrabbleWordWidgetState();
}

class ScrabbleWordWidgetState extends State<ScrabbleWordWidget> {
  bool isBingo = false;

  void onToggleBingo() {
    setState(() => isBingo = !isBingo);
    Provider.of<ActivePlay>(context, listen: false).toggleBingo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.interactive) return;
        widget.word.toggleWordMultiplier();
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        Provider.of<ActivePlay>(context, listen: false).notifyListeners();
        setState(() {});
      },
      child: Consumer<AppState>(
        builder: (_, appState, __) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.hardEdge,
            child: Container(
              color: widget.word.wordMultiplier.editionColor(appState.edition),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      ...widget.word.playedLetters
                          .map((l) => ScrabbleTile(l, interactive: widget.interactive))
                          .toList(),
                      Text(
                        widget.word.score.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () => onToggleBingo(),
                        icon: isBingo ? Icon(Icons.star) : Icon(Icons.star_border),
                      ),
                      OutlinedButton.icon(
                        icon: Icon(Icons.multiple_stop_rounded),
                        onPressed: () {
                          Provider.of<ActivePlay>(context, listen: false).toggleWordMultiplier();
                          setState(() {});
                        },
                        label: Text(
                          Provider.of<ActivePlay>(context, listen: false)
                              .playedWord
                              .wordMultiplier
                              .label,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A widget that displays a single letter as a ScrabbleTile widget.
class ScrabbleTile extends StatefulWidget {
  final PlayedLetter letter;
  final bool interactive;

  const ScrabbleTile(this.letter, {required this.interactive, super.key});

  @override
  ScrabbleTileState createState() => ScrabbleTileState();
}

class ScrabbleTileState extends State<ScrabbleTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.interactive) return;
        widget.letter.toggleLetterMultiplier();
        setState(() {});
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        Provider.of<ActivePlay>(context, listen: false).notifyListeners();
      },
      child: Consumer<AppState>(
        builder: (context, appState, __) {
          Color boxColor = widget.letter.letterMultiplier.editionColor(appState.edition);
          Color textColor = boxColor.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
          TextTheme textTheme = Theme.of(context).textTheme;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: boxColor,
            ),
            child: Column(
              children: [
                Text(
                  widget.letter.score.toString(),
                  textAlign: TextAlign.right,
                  style: textTheme.labelSmall!.copyWith(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                Text(
                  widget.letter.letter,
                  style:
                      textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500, color: textColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
