import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// A helper class to manage the word_database file.
/// It mainly contains the word_list table.
class WordListDBHelper {
  static const _databaseName = 'word_database.db';
  static const _databaseVersion = 1;

  /// The default table name
  static const defaultTable = 'word_list';

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
    await db.execute('''
          CREATE TABLE $defaultTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnWord TEXT NOT NULL
          )
          ''');
  }

  /// Insert a row into the database
  Future<int> insert(Map<String, dynamic> row, {Database? txn}) async {
    final db = txn ?? await instance.database;
    return await db.insert(defaultTable, row);
  }

  /// Query all rows in the table
  Future<List<Map<String, dynamic>>> queryAllRows({Database? txn}) async {
    final db = txn ?? await instance.database;
    return await db.query(defaultTable);
  }

  /// Queries the number of rows in the table
  Future<int?> queryRowCount({Database? txn}) async {
    final db = txn ?? await instance.database;
    return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $defaultTable'),
    );
  }

  /// Delete all rows in the table
  Future<int> deleteAll({Database? txn}) async {
    final db = txn ?? await instance.database;
    return await db.delete(defaultTable);
  }

  /// Loads the 2006 tournament word list.
  Future<void> importWordList() async {
    final wordListString =
        await rootBundle.loadString('assets/txt/word_list.txt');
    final wordList = wordListString.split('\n');
    final batch = _database!.batch();
    for (var word in wordList) {
      if (word.trim().isNotEmpty) {
        batch.insert(defaultTable, {columnWord: word});
      }
    }
    await batch.commit(noResult: true);
  }

  /// Whether any of the given words exist in the database
  Future<bool> wordExistsInList(List<String> words) async {
    final db = await database;
    final placeholders = List.filled(words.length, '?').join(', ');
    final query = 'SELECT 1 FROM $defaultTable WHERE word IN ($placeholders) LIMIT 1';
    final results = await db.rawQuery(query, words);
    return results.isNotEmpty;
  }

  /// Whether the database is already populated
  Future<bool> isDatabasePopulated() async {
    final db = await database;
    final count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $defaultTable'));
    if (count != null && count > 0) {
      return true;
    } else {
      return false;
    }
  }

  /// Inject a database for testing
  static void testConstructor(Database testDb) {
    _database = testDb;
  }
}
