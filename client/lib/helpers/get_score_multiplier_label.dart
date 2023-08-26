import '../models/game_state.dart';

String getScoreMultiplierLabel(WordMultiplier multiplier) {
  switch (multiplier) {
    case WordMultiplier.none:
      return '1X';
    case WordMultiplier.doubleWord:
      return '2X';
    case WordMultiplier.tripleWord:
      return '3X';
  }
}
