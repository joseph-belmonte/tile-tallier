import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../play_game/data/helpers/word_database_helper.dart';
import '../../data/sources/local/word_of_the_day_service.dart';

/// Provider for the WordOfTheDayService.
final wordOfTheDayServiceProvider = Provider<WordOfTheDayService>((ref) {
  final dbHelper = WordListDBHelper.instance;
  return WordOfTheDayService(dbHelper);
});

/// Provider for fetching the Word of the Day.
final wordOfTheDayProvider = FutureProvider<String>((ref) async {
  final wordService = ref.read(wordOfTheDayServiceProvider);
  return await wordService.getWordOfTheDay();
});
