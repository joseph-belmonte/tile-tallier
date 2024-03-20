import 'word.dart';

/// Accepts a list of PlayedWord objects and a boolean value for whether or not
/// the play is a bingo.
/// A word is a list of PlayedLetter objects.
/// A bingo is when a player uses all 7 letters in their rack in a single turn.
class Play {
  /// A list of PlayedWord objects that make up the play.
  List<Word> playedWords = [];

  /// Whether or not the play is a bingo.
  bool isBingo;

  /// Creates a new Play instance.
  Play({this.playedWords = const [], this.isBingo = false});

  /// Returns the score for the play by summing the scores for each PlayedWord
  /// object.
  /// * If the play is a bingo, 50 points are added to the score.
  int get score {
    var score = 0;
    for (var word in playedWords) {
      score += word.score;
    }
    if (isBingo) score += 50;
    return score;
  }

  /// Adds a word to the list of played words for this play.
  void addWord(Word word) {
    playedWords = [...playedWords, word];
  }

  /// Toggle the value of isBingo.
  void toggleBingo() => isBingo = !isBingo;
}
