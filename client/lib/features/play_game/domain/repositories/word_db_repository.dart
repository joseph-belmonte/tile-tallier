import 'package:sqflite/sqflite.dart';

import '../../../../enums/word_theme.dart';
import '../../data/helpers/word_database_helper.dart';

/// A repository for interacting with the word database.
class WordDbRepository {
  final WordListDBHelper _wordListDBHelper = WordListDBHelper.instance;
  late final Future<Database> _databaseFuture;

  /// Gets the database.
  Future<Database> get database async => await _databaseFuture;

  /// Creates a new [WordDbRepository] instance.
  WordDbRepository();

  /// Returns a theme's table name and path.
  String _getTableName(WordTheme theme) {
    try {
      final tableName =
          _wordListDBHelper.getTableNameAndPath(theme)['tableName']!;
      return tableName;
    } catch (e) {
      throw Exception('Error getting table name and path: $e');
    }
  }

  /// Whether a word exists in the theme's table.
  Future<bool> isWordValid(String word, WordTheme theme) async {
    final tableName = _getTableName(theme);
    final isValid = await _wordListDBHelper.wordExists(
      word,
      tableName: tableName,
    );

    return isValid;
  }

  /// Returns all rows in the table.
  Future<List<Map<String, dynamic>>> queryAllRows({
    required WordTheme theme,
  }) async {
    try {
      final tableName = _getTableName(theme);
      return await _wordListDBHelper.queryAllRows(tableName: tableName);
    } on Exception catch (e) {
      throw Exception('Error querying all rows: $e');
    }
  }

  /// Returns the number of rows in the table.
  Future<int?> queryRowCount({required WordTheme theme}) {
    try {
      return _wordListDBHelper.queryRowCount(theme: theme);
    } on Exception catch (e) {
      throw Exception('Error querying row count: $e');
    }
  }

  /// Populates the word table for a given theme.
  Future<void> populateTable({required WordTheme theme}) {
    try {
      return _wordListDBHelper.populateTable(theme: theme);
    } on Exception catch (e) {
      throw Exception('Error populating table: $e');
    }
  }

  /// Returns the entire word list for a given theme.
  Future<List<String>> getWordList(WordTheme theme) {
    try {
      return _wordListDBHelper.getWordList(theme);
    } on Exception catch (e) {
      throw Exception('Error getting word list: $e');
    }
  }
}
