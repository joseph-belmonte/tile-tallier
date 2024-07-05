import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tile_tally/features/play_game/domain/models/game.dart';
import 'package:tile_tally/features/play_game/domain/models/game_player.dart';
import 'package:tile_tally/features/play_game/domain/models/letter.dart';
import 'package:tile_tally/features/play_game/domain/models/play.dart';
import 'package:tile_tally/features/play_game/domain/models/player.dart';

import 'package:tile_tally/features/play_game/domain/models/word.dart';
import 'package:tile_tally/features/view_past_games/data/game_storage_database_helper.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Mocking the path_provider
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/path_provider'),
    (MethodCall methodCall) async => '.',
  );

  // Initialize FFI
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('GameStorageDatabaseHelper tests', () {
    late Database db; // Database instance
    late Directory tempDir; // Temp directory used for testing

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('tile_tally');
      final dbPath = '${tempDir.path}/game_db_test.db';

      db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE games (
              id TEXT PRIMARY KEY
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
          await db
              .execute('CREATE INDEX idx_word_id ON playedLetters (wordId)');
        },
      );

      GameStorageDatabaseHelper.testConstructor(db);
    });

    test('Insert an empty game (no plays) into the database and fetch it',
        () async {
      final game = Game(
        id: Uuid().v4(),
        players: [
          Player(id: Uuid().v4(), name: 'Player 1'),
          Player(id: Uuid().v4(), name: 'Player 2'),
        ],
        currentPlay: Play(id: Uuid().v4(), timestamp: DateTime.now()),
        currentWord: Word(id: Uuid().v4()),
      );

      await GameStorageDatabaseHelper.instance.insertGame(game);

      final fetchedGame =
          await GameStorageDatabaseHelper.instance.fetchGame(game.id);

      expect(fetchedGame.id, game.id);
      expect(fetchedGame.players.length, game.players.length);
      expect(fetchedGame.players.first.name, game.players.first.name);
    });

    test('Insert a game with plays into the database and fetch it', () async {
      final player1play = <Play>[
        Play(
          id: Uuid().v4(),
          timestamp: DateTime.now(),
          isBingo: true,
          playedWords: [
            Word(
              id: Uuid().v4(),
              // ONE = 3 points
              playedLetters: <Letter>[
                Letter(
                  id: Uuid().v4(),
                  letter: 'O',
                ),
                Letter(id: Uuid().v4(), letter: 'N'),
                Letter(id: Uuid().v4(), letter: 'E'),
              ],
            ),
          ],
        ),
      ];

      final player2play = <Play>[
        Play(
          id: Uuid().v4(),
          timestamp: DateTime.now(),
          isBingo: false,
          playedWords: [
            Word(
              id: Uuid().v4(),
              // TWO = 6 points
              playedLetters: <Letter>[
                Letter(id: Uuid().v4(), letter: 'T'),
                Letter(id: Uuid().v4(), letter: 'W'),
                Letter(id: Uuid().v4(), letter: 'O'),
              ],
            ),
          ],
        ),
      ];

      final game = Game(
        id: Uuid().v4(),
        players: [
          Player(id: Uuid().v4(), name: 'Player 1', plays: player1play),
          Player(id: Uuid().v4(), name: 'Player 2', plays: player2play),
        ],
        currentPlay: Play(id: Uuid().v4(), timestamp: DateTime.now()),
        currentWord: Word(id: Uuid().v4()),
      );

      await GameStorageDatabaseHelper.instance.insertGame(game);

      final fetchedGame =
          await GameStorageDatabaseHelper.instance.fetchGame(game.id);

      expect(fetchedGame.id, game.id);
      expect(fetchedGame.players.length, game.players.length);
      expect(fetchedGame.players.first.name, game.players.first.name);
      expect(
        fetchedGame.players.first.plays.length,
        game.players.first.plays.length,
      );
      expect(fetchedGame.players.first.score, 53);
      expect(fetchedGame.players.last.score, 6);
      expect(fetchedGame.isFavorite, false);
    });

    test('Delete a game from the database', () async {
      final game = Game(
        id: Uuid().v4(),
        players: <Player>[
          Player(id: Uuid().v4(), name: 'Player 1'),
          Player(id: Uuid().v4(), name: 'Player 2'),
        ],
        currentPlay: Play(id: Uuid().v4(), timestamp: DateTime.now()),
        currentWord: Word(id: Uuid().v4()),
      );

      await GameStorageDatabaseHelper.instance.insertGame(game);
      await GameStorageDatabaseHelper.instance.deleteGame(game.id);

      expect(
        () async => await GameStorageDatabaseHelper.instance.fetchGame(game.id),
        throwsException,
      );
    });

    tearDown(() async {
      await db.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });
  });
}
