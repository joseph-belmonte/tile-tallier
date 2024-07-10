import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../theme/controllers/theme_providers.dart';
import '../../../../../utils/helpers.dart';
import '../../../../core/domain/models/letter.dart';

/// A widget that displays a single letter as a ScrabbleTile widget.
class ScrabbleTile extends ConsumerWidget {
  /// The letter to display.
  final Letter letter;

  /// The callback to call when the tile is tapped.
  final VoidCallback onTap;

  /// Creates a new [ScrabbleTile] instance.
  const ScrabbleTile(this.letter, this.onTap, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrabbleEdition = ref.watch(scrabbleEditionProvider);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: getTileColor(letter, scrabbleEdition),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 3,
              right: 3,
              child: Text(
                letter.score == 0 ? '' : letter.score.toString(),
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ),
            Center(
              child: Text(
                letter.letter.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
