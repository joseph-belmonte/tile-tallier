import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../play_game/domain/models/game.dart';
import '../../play_game/domain/models/game_player.dart';
import '../../play_game/domain/models/letter.dart';
import '../../play_game/domain/models/play.dart';
import '../../play_game/domain/models/word.dart';
import '../domain/models/past_game.dart';
import '../domain/models/player.dart';

/// A helper class for the game storage database.
class GameStorageDatabaseHelper {
  /// The singleton instance of the [GameStorageDatabaseHelper].
  static final GameStorageDatabaseHelper instance =
      GameStorageDatabaseHelper._init();
  static Database? _database;

  GameStorageDatabaseHelper._init();

  /// Returns the database.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('game_database.db');
    return _database!;
  }

  // Initializes the database.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Creates the database tables.
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
        gameId TEXT,
        name TEXT,
        endRack TEXT,
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
        FOREIGN KEY (playerId) REFERENCES players (id),
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

    // Adding indexes to improve query performance
    await db.execute('CREATE INDEX idx_game_id ON players (gameId)');
    await db.execute('CREATE INDEX idx_player_id ON plays (playerId)');
    await db.execute('CREATE INDEX idx_play_id ON words (playId)');
    await db.execute('CREATE INDEX idx_word_id ON playedLetters (wordId)');
  }

  /// Inserts a game into the database.
  Future<void> insertGame(Game game) async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.insert(
        'games',
        {'id': game.id},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (var player in game.players) {
        await txn.insert(
          'players',
          {
            'id': player.id,
            'gameId': game.id,
            'name': player.name,
            'endRack': player.endRack,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        for (var play in player.plays) {
          await txn.insert(
            'plays',
            {
              'id': play.id,
              'playerId': player.id,
              'gameId': game.id,
              'isBingo': play.isBingo ? 1 : 0,
              'timestamp': play.timestamp.toIso8601String(),
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          for (var word in play.playedWords) {
            await txn.insert(
              'words',
              {
                'id': word.id,
                'playId': play.id,
                'word': word.word,
                'score': word.score,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );

            for (var playedLetter in word.playedLetters) {
              await txn.insert(
                'playedLetters',
                {
                  'id': playedLetter.id,
                  'wordId': word.id,
                  'letter': playedLetter.letter,
                  'scoreMultiplier': playedLetter.scoreMultiplier.index,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            }
          }
        }
      }
    });
  }

  /// Fetches a game from the database.
  Future<PastGame> fetchGame(String id) async {
    final db = await database;

    final gameMap = await db.query('games', where: 'id = ?', whereArgs: [id]);

    if (gameMap.isEmpty) {
      throw Exception('Game not found');
    }

    return await _assembleGame(gameMap.first);
  }

  /// Toggles the favorite status of a game.
  Future<void> toggleFavorite(String id) async {
    final db = await database;

    await db.rawUpdate(
      '''
      UPDATE games
      SET is_favorite = 1 - is_favorite
      WHERE id = ?
    ''',
      [id],
    );
  }

  /// Fetches all games from the database.
  Future<List<PastGame>> fetchGames() async {
    final db = await database;

    final gamesMap = await db.query('games');

    final games = await Future.wait(
      gamesMap.map((gameMap) async {
        return await _assembleGame(gameMap);
      }).toList(),
    );

    return games;
  }

  /// Fetches all players from the database.
  Future<List<Player>> fetchAllPlayers() async {
    final db = await database;
    final result = await db.query('players');
    return result.map(Player.fromJson).toList();
  }

  /// Update a player's name.
  Future<void> updatePlayerName(String playerId, String newName) async {
    final db = await database;
    await db.update(
      'players',
      {'name': newName},
      where: 'id = ?',
      whereArgs: [playerId],
    );
  }

  Future<PastGame> _assembleGame(Map<String, dynamic> gameJson) async {
    final db = await database;

    final gameId = gameJson['id'] as String;

    final playersMap =
        await db.query('players', where: 'gameId = ?', whereArgs: [gameId]);
    final players = await Future.wait(
      playersMap.map((player) async {
        var playerObj = GamePlayer.fromJson(player);

        final playsMap = await db
            .query('plays', where: 'playerId = ?', whereArgs: [playerObj.id]);

        final plays = await Future.wait(
          playsMap.map((play) async {
            var playObj = Play.fromJson(play);

            final wordsMap = await db
                .query('words', where: 'playId = ?', whereArgs: [playObj.id]);
            final words = await Future.wait(
              wordsMap.map((word) async {
                var wordObj = Word.fromJson(word);

                final lettersMap = await db.query(
                  'playedLetters',
                  where: 'wordId = ?',
                  whereArgs: [wordObj.id],
                );
                final letters = lettersMap.map(Letter.fromJson).toList();

                wordObj = wordObj.copyWith(playedLetters: letters);
                return wordObj;
              }).toList(),
            );

            playObj = playObj.copyWith(playedWords: words);
            return playObj;
          }).toList(),
        );

        playerObj = playerObj.copyWith(plays: plays);
        return playerObj;
      }).toList(),
    );

    final gameJsonMutable = Map<String, dynamic>.from(gameJson);

    // Ensure currentPlay and currentWord are not null
    gameJsonMutable['currentPlay'] =
        gameJson['currentPlay'] ?? Play.createNew().toJson();
    gameJsonMutable['currentWord'] =
        gameJson['currentWord'] ?? Word.createNew().toJson();

    final game = PastGame.fromJson(gameJsonMutable).copyWith(players: players);

    return game;
  }

  /// Deletes a game from the database.
  Future<void> deleteGame(String id) async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.delete('games', where: 'id = ?', whereArgs: [id]);
      await txn.delete('players', where: 'gameId = ?', whereArgs: [id]);

      final plays =
          await txn.query('plays', where: 'gameId = ?', whereArgs: [id]);
      for (var play in plays) {
        await txn.delete('words', where: 'playId = ?', whereArgs: [play['id']]);
        await txn.delete(
          'playedLetters',
          where: 'wordId IN (SELECT id FROM words WHERE playId = ?)',
          whereArgs: [play['id']],
        );
      }

      await txn.delete('plays', where: 'gameId = ?', whereArgs: [id]);
    });
  }

  /// Deletes all games from the database.
  Future<void> deleteAllGames() async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.delete('words');
      await txn.delete('playedLetters');
      await txn.delete('plays');
      await txn.delete('players');
      await txn.delete('games');
    });
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
