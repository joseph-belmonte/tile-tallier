import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../enums/word_theme.dart';

/// A helper class to manage the word_database file.
/// It mainly contains the word_list table.
class WordListDBHelper {
  static const _databaseName = 'word_database.db';
  static const _databaseVersion = 1;

  /// The default table name
  static const defaultTable = 'word_list';

  /// The wordle table name
  static const wordleTable = 'wordle_list';

  /// The family table name
  static const familyTable = 'family_list';

  /// The avian table name
  static const avianTable = 'avian_list';

  /// The maritime table name
  static const maritimeTable = 'maritime_list';

  /// The arbor table name
  static const arborTable = 'arbor_list';

  /// A list of all the tables in the database
  final tables = [
    defaultTable,
    wordleTable,
    familyTable,
    avianTable,
    maritimeTable,
    arborTable,
  ];

  /// The id column name
  static const columnId = 'id';

  /// The word column name
  static const columnWord = 'word';

  WordListDBHelper._privateConstructor();

  /// The singleton instance
  static final WordListDBHelper instance =
      WordListDBHelper._privateConstructor();

  static Database? _database;

  /// Returns the database, initializing it if necessary
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Helper method to open the database
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.transaction((txn) async {
      for (var table in tables) {
        await txn.execute('''
        CREATE TABLE $table (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnWord TEXT NOT NULL
        )
      ''');
      }
    });
  }

  // Method to get table name and path based on the theme
  Map<String, String> _getTableNameAndPath(WordTheme theme) {
    switch (theme) {
      case WordTheme.basic:
        return {'tableName': defaultTable, 'path': WordTheme.basic.path};
      case WordTheme.wordle:
        return {'tableName': wordleTable, 'path': WordTheme.wordle.path};
      case WordTheme.family:
        return {'tableName': familyTable, 'path': WordTheme.family.path};
      case WordTheme.avian:
        return {'tableName': avianTable, 'path': WordTheme.avian.path};
      case WordTheme.maritime:
        return {'tableName': maritimeTable, 'path': WordTheme.maritime.path};
      case WordTheme.arbor:
        return {'tableName': arborTable, 'path': WordTheme.arbor.path};
      default:
        throw Exception('Cannot find word list for ${theme.name}');
    }
  }

  /// Insert a row into the specified table
  Future<int> insert({
    required String tableName,
    required Map<String, dynamic> row,
    Database? txn,
  }) async {
    final db = txn ?? await instance.database;
    return await db.insert(tableName, row);
  }

  /// Query all rows in the table
  Future<List<Map<String, dynamic>>> queryAllRows({
    required String tableName,
    Database? txn,
  }) async {
    final db = txn ?? await instance.database;
    return await db.query(tableName);
  }

  /// Queries the number of rows in the table
  Future<int?> queryRowCount({required WordTheme theme, Database? txn}) async {
    final db = txn ?? await instance.database;

    // Given the theme, find the tableName
    final tableName = _getTableNameAndPath(theme)['tableName']!;

    return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $tableName'),
    );
  }

  /// Delete all rows in the specified table
  Future<int> deleteAll({required String tableName, Database? txn}) async {
    final db = txn ?? await instance.database;
    return await db.delete(tableName);
  }

  /// Loads the word list at a given path and inserts it into the 'word_database.db
  Future<void> populateTable({required WordTheme theme}) async {
    final tableInfo = _getTableNameAndPath(theme);
    final path = tableInfo['path']!;
    final tableName = tableInfo['tableName']!;

    final wordListString = await rootBundle.loadString(path);
    final wordList = wordListString.split('\n');
    final batch = _database!.batch();
    for (var word in wordList) {
      if (word.trim().isNotEmpty) {
        batch.insert(tableName, {columnWord: word.trim().toLowerCase()});
      }
    }
    await batch.commit(noResult: true);
  }

  /// Get a list of words from the database
  Future<List<String>> getWordList(WordTheme theme) async {
    final db = await database;

    final tableName = _getTableNameAndPath(theme)['tableName']!;

    final results = await db.query(tableName, columns: [columnWord]);
    return results.map((row) => row[columnWord] as String).toList();
  }

  /// Whether any of the given words exist in the database
  Future<bool> wordExistsInList(
    List<String> words, {
    String tableName = defaultTable,
  }) async {
    final db = await database;
    final placeholders = List.filled(words.length, '?').join(', ');
    final query =
        'SELECT 1 FROM $tableName WHERE word IN ($placeholders) LIMIT 1';
    final results = await db.rawQuery(query, words);
    return results.isNotEmpty;
  }

  /// Whether each table in the database in populated
  Future<bool> isDatabasePopulated() async {
    try {
      final db = await database;
      for (var table in tables) {
        final count = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $table'),
        );
        if (count == null || count == 0) {
          return false;
        }
      }
      return true;
    } catch (e) {
      throw 'Error checking if database is populated: $e';
    }
  }

  /// Inject a database for testing
  static void testConstructor(Database testDb) {
    _database = testDb;
  }
}
