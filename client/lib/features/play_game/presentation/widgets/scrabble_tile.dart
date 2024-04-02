import 'package:flutter/material.dart';
import '../../../../enums/scrabble_edition.dart';
import '../../../../utils/helpers.dart';
import '../../domain/models/letter.dart';

/// A widget that displays a single letter as a ScrabbleTile widget.
class ScrabbleTile extends StatefulWidget {
  /// The letter to display.
  final Letter letter;

  /// The callback to call when the tile is tapped.
  final VoidCallback onTap;

  /// Creates a new [ScrabbleTile] instance.
  const ScrabbleTile(this.letter, this.onTap, {super.key});

  @override
  State<ScrabbleTile> createState() => _ScrabbleTileState();
}

class _ScrabbleTileState extends State<ScrabbleTile> {
  @override
  Widget build(BuildContext context) {
    final boxColor = getTileColor(widget.letter, ScrabbleEdition.classic);
    final textColor = boxColor.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: widget.onTap,
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
              widget.letter.score == 0 ? '' : widget.letter.score.toString(),
              textAlign: TextAlign.right,
              style: textTheme.labelSmall!.copyWith(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            Text(
              widget.letter.letter.toUpperCase(),
              style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
