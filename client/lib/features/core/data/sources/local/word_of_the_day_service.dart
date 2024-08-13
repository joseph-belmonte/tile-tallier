import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../play_game/data/helpers/word_database_helper.dart';

/// Service to handle fetching the Word of the Day.
class WordOfTheDayService {
  final WordListDBHelper _wordListDBHelper;

  /// Creates a new WordOfTheDayService.
  WordOfTheDayService(this._wordListDBHelper);

  /// Fetches the Word of the Day, either from local storage or by querying the database.
  Future<String> getWordOfTheDay() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T').first;
    final savedDate = prefs.getString('wordOfTheDayDate');
    final savedWord = prefs.getString('wordOfTheDay');

    if (savedDate == today && savedWord != null) {
      return savedWord;
    } else {
      final wordList = await _wordListDBHelper.queryAllRows(
        tableName: WordListDBHelper.defaultTable,
      );
      final randomWord = wordList.isNotEmpty
          ? wordList[Random().nextInt(wordList.length)]
              [WordListDBHelper.columnWord]
          : 'Flutter';

      prefs.setString('wordOfTheDayDate', today);
      prefs.setString('wordOfTheDay', randomWord);

      return randomWord;
    }
  }
}
