/// A helper class for calling the create methods
library;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A helper class for creating the database tables.
class MasterDatabaseHelper {
  /// The singleton instance for the [MasterDatabaseHelper] class.
  static final MasterDatabaseHelper instance = MasterDatabaseHelper._init();
  static Database? _database;

  MasterDatabaseHelper._init();

  /// Returns the database, initializing it if necessary.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('game_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  /// Creates the database tables, only used for testing.
  Future<void> testCreateDB(Database db, int version) {
    return _createDB(db, version);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE games (
        id TEXT PRIMARY KEY,
        is_favorite INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE players (
        id TEXT PRIMARY KEY,
        name TEXT UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE game_players (
        id TEXT PRIMARY KEY,
        playerId TEXT,
        gameId TEXT,
        name TEXT,
        endRack TEXT,
        FOREIGN KEY (playerId) REFERENCES players (id),
        FOREIGN KEY (gameId) REFERENCES games (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE plays (
        id TEXT PRIMARY KEY,
        playerId TEXT,
        gameId TEXT,
        isBingo INTEGER,
        timestamp TEXT,
        playedWords TEXT,
        FOREIGN KEY (playerId) REFERENCES game_players (id),
        FOREIGN KEY (gameId) REFERENCES games (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE words (
        id TEXT PRIMARY KEY,
        playId TEXT,
        word TEXT,
        score INTEGER,
        FOREIGN KEY (playId) REFERENCES plays (id)
      )
    ''');

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

  /// Closes the database.
  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }

  /// Inject a database for testing
  static void testConstructor(Database testDb) {
    _database = testDb;
  }
}
