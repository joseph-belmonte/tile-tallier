import 'package:sqflite/sqflite.dart';
import '../../../core/domain/models/word.dart';

import '../../domain/models/database_helper.dart';

/// Helper class for the words table in the database.
class WordTableHelper extends DatabaseHelper {
  /// Creates the words table in the database.
  @override
  Future<void> createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE words (
        id TEXT PRIMARY KEY,
        playId TEXT,
        word TEXT,
        score INTEGER,
        FOREIGN KEY (playId) REFERENCES plays (id)
      )
    ''');
  }

  /// Inserts a word into the words table.
  Future<void> insertWord(Word word) async {
    final db = await database;
    await db.insert(
      'words',
      word.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all words associated with a play.
  Future<List<Word>> fetchWordsByPlayId(String playId) async {
    final db = await database;
    final result =
        await db.query('words', where: 'playId = ?', whereArgs: [playId]);
    return result.map(Word.fromJson).toList();
  }

  /// Deletes all words associated with a play.
  Future<void> deleteWordsByPlayId(String playId) async {
    final db = await database;
    await db.delete('words', where: 'playId = ?', whereArgs: [playId]);
  }
}
