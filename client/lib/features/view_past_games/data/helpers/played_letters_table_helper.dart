import 'package:sqflite/sqflite.dart';
import '../../../play_game/domain/models/letter.dart';
import 'database_helper.dart';

/// Helper class for the playedLetters table in the database.
class PlayedLetterTableHelper extends DatabaseHelper {
  /// Creates the playedLetters table in the database.
  Future<void> createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE playedLetters (
        id TEXT PRIMARY KEY,
        wordId TEXT,
        letter TEXT,
        scoreMultiplier INTEGER,
        FOREIGN KEY (wordId) REFERENCES words (id)
      )
    ''');
  }

  /// Inserts a played letter into the playedLetters table.
  Future<void> insertPlayedLetter(Letter playedLetter) async {
    final db = await database;
    await db.insert(
      'playedLetters',
      playedLetter.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all played letters associated with a word.
  Future<List<Letter>> fetchLettersByWordId(String wordId) async {
    final db = await database;
    final result = await db
        .query('playedLetters', where: 'wordId = ?', whereArgs: [wordId]);
    return result.map(Letter.fromJson).toList();
  }

  /// Deletes all played letters associated with a word.
  Future<void> deleteLettersByWordId(String wordId) async {
    final db = await database;
    await db.delete('playedLetters', where: 'wordId = ?', whereArgs: [wordId]);
  }
}
