import 'package:sqflite/sqflite.dart';
import '../../../core/domain/models/letter.dart';
import '../../domain/models/database_helper.dart';

/// Helper class for the playedLetters table in the database.
class PlayedLetterTableHelper extends DatabaseHelper {
  /// Creates the playedLetters table in the database.
  @override
  Future<void> createDB(Database db, int version) async {
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
  Future<void> insertPlayedLetter(
    Letter playedLetter,
    String wordId,
    Transaction txn,
  ) async {
    await txn.insert(
      'playedLetters',
      {
        'id': playedLetter.id,
        'wordId': wordId,
        'letter': playedLetter.letter,
        'scoreMultiplier': playedLetter.scoreMultiplier.index,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all played letters associated with a word.
  Future<List<Letter>> fetchLetters({required String wordId}) async {
    final db = await database;
    final result = await db
        .query('playedLetters', where: 'wordId = ?', whereArgs: [wordId]);
    return result.map(Letter.fromJson).toList();
  }

  /// Deletes all played letters associated with a word.
  Future<void> deleteLetters({required String wordId}) async {
    final db = await database;
    await db.delete('playedLetters', where: 'wordId = ?', whereArgs: [wordId]);
  }
}
