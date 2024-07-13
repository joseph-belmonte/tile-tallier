import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tile_tally/features/core/domain/models/game.dart';
import 'package:tile_tally/features/history/domain/models/player.dart';
import 'package:tile_tally/features/history/domain/repositories/history_repository.dart';
import 'package:tile_tally/utils/logger.dart';

void main() {
  sqfliteFfiInit();

  late Database database;
  late HistoryRepository historyRepository;

  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;

    database = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE games (
            id TEXT PRIMARY KEY,
            isFavorite INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE players (
            id TEXT PRIMARY KEY,
            name TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE game_players (
            id TEXT PRIMARY KEY,
            playerId TEXT,
            gameId TEXT,
            name TEXT,
            FOREIGN KEY (playerId) REFERENCES players (id),
            FOREIGN KEY (gameId) REFERENCES games (id)
          )
        ''');
      },
    );

    historyRepository = HistoryRepository(Future.value(database));
  });

  tearDownAll(() async {
    await database.close();
  });

  group('HistoryRepository Tests', () {
    test('Save and fetch game', () async {
      final game = Game(
        id: 'game1',
        isFavorite: false,
        players: [],
        currentPlay: null,
        currentWord: null,
      );
      await database.transaction((txn) async {
        await historyRepository.saveGame(game, txn);
      });

      logger.d(
        await database.transaction((txn) async {
          return await txn.query('games');
        }),
      );

      final fetchedGame = await historyRepository.fetchGame('game1');
      expect(fetchedGame.id, equals('game1'));
    });

    test('Delete game', () async {
      final game = Game(
        id: 'game2',
        isFavorite: false,
        players: [],
        currentPlay: null,
        currentWord: null,
      );
      await database.transaction((txn) async {
        await historyRepository.saveGame(game, txn);
      });

      await historyRepository.deleteGame('game2');

      final fetchedGame = await historyRepository.fetchGame('game2');
      expect(fetchedGame, isNull);
    });

    test('Toggle favorite', () async {
      final game = Game(
        id: 'game3',
        isFavorite: false,
        players: [],
        currentPlay: null,
        currentWord: null,
      );
      await database.transaction((txn) async {
        await historyRepository.saveGame(game, txn);
      });

      await historyRepository.toggleFavorite('game3');

      final fetchedGame = await historyRepository.fetchGame('game3');
      expect(fetchedGame.isFavorite, equals(true));
    });

    test('Save and fetch player', () async {
      final player = Player(id: 'player1', name: 'John Doe');
      await database.transaction((txn) async {
        await historyRepository.savePlayer(player, txn);
      });

      final fetchedPlayer = await database.transaction((txn) async {
        return await historyRepository.fetchPlayer('player1', txn);
      });

      expect(fetchedPlayer!.name, equals('John Doe'));
    });

    test('Update player name', () async {
      final player = Player(id: 'player2', name: 'Jane Doe');
      await database.transaction((txn) async {
        await historyRepository.savePlayer(player, txn);
      });

      await historyRepository.updatePlayerName(
        playerId: 'player2',
        newName: 'Jane Smith',
      );

      final fetchedPlayer = await database.transaction((txn) async {
        return await historyRepository.fetchPlayer('player2', txn);
      });

      expect(fetchedPlayer!.name, equals('Jane Smith'));
    });

    test('Delete player', () async {
      final player = Player(id: 'player3', name: 'Alice');
      await database.transaction((txn) async {
        await historyRepository.savePlayer(player, txn);
      });

      await historyRepository.deletePlayer('player3');

      final fetchedPlayer = await database.transaction((txn) async {
        return await historyRepository.fetchPlayer('player3', txn);
      });

      expect(fetchedPlayer, isNull);
    });

    test('Fetch all players', () async {
      final player1 = Player(id: 'player4', name: 'Bob');
      final player2 = Player(id: 'player5', name: 'Charlie');
      await database.transaction((txn) async {
        await historyRepository.savePlayer(player1, txn);
        await historyRepository.savePlayer(player2, txn);
      });

      final players = await historyRepository.fetchAllPlayers();
      expect(players.length, equals(2));
    });

    test('Fetch games by player ID', () async {
      final game = Game(
        id: 'game4',
        isFavorite: false,
        players: [],
        currentPlay: null,
        currentWord: null,
      );
      final player = Player(id: 'player6', name: 'Dave');
      await database.transaction((txn) async {
        await historyRepository.saveGame(game, txn);
        await historyRepository.savePlayer(player, txn);
        await database.insert('game_players', {
          'id': 'game4_player6',
          'playerId': 'player6',
          'gameId': 'game4',
          'name': 'Dave',
        });
      });

      final games = await historyRepository.fetchGamesByPlayerId('player6');
      expect(games.length, equals(1));
    });

    test('Submit game data', () async {
      final game = Game(
        id: 'game5',
        isFavorite: false,
        players: [],
        currentPlay: null,
        currentWord: null,
      );
      await historyRepository.submitGameData(game);

      final fetchedGame = await historyRepository.fetchGame('game5');
      expect(fetchedGame.id, equals('game5'));
    });
  });
}
