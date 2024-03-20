import 'package:flutter/material.dart';
import '../../../../../enums/scrabble_edition.dart';
import '../../domain/models/letter.dart';

/// A widget that displays a single letter as a ScrabbleTile widget.
class ScrabbleTile extends StatefulWidget {
  /// The letter to display.
  final Letter letter;

  /// Creates a new [ScrabbleTile] instance.
  const ScrabbleTile(this.letter, {super.key});

  @override
  State<ScrabbleTile> createState() => _ScrabbleTileState();
}

class _ScrabbleTileState extends State<ScrabbleTile> {
  @override
  Widget build(BuildContext context) {
    var boxColor = widget.letter.letterMultiplier.editionColor(ScrabbleEdition.classic);
    var textColor = boxColor.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        widget.letter.toggleLetterMultiplier();
        setState(() {});
      },
      child: Container(
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
              style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
