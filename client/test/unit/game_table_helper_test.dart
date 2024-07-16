import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tile_tally/features/history/data/helpers/games_table_helper.dart';

import 'package:tile_tally/features/history/data/helpers/master_database_helper.dart';

void main() {
  sqfliteFfiInit();

  late Database database;
  // ignore: unused_local_variable
  late GameTableHelper gameTableHelper;

  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    database = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        await MasterDatabaseHelper.instance.testCreateDB(db, version);
      },
    );

    gameTableHelper = GameTableHelper();
  });

  // group('GameTableHelper Tests', () {
  //   test('Insert and Fetch Game', () async {
  //     await database.transaction((txn) async {
  //       await gameTableHelper.insertGame(game1, txn);
  //     });

  //     // Print out the games table
  //     logger.d(await database.query('games'));

  //     final rawGames = await database.rawQuery('SELECT * FROM games');
  //     logger.d(rawGames);

  //     try {
  //       final fetchedGame = await database.transaction((txn) async {
  //         await gameTableHelper.fetchGame(game1.id);
  //       });

  //       // Print the result of the fetch operation
  //       logger.d(fetchedGame);
  //       expect(fetchedGame.id, equals('game1'));
  //     } catch (e) {
  //       // Fail the test
  //       logger.e(e);
  //       fail('Failed to fetch game');
  //     }
  //   });

  //   test('Toggle Favorite', () async {
  //     await database.transaction((txn) async {
  //       await gameTableHelper.insertGame(game2, txn);
  //     });

  //     await gameTableHelper.toggleFavorite('game2');

  //     final fetchedGame = await gameTableHelper.fetchGame('game2');
  //     expect(fetchedGame.isFavorite, equals(true));
  //   });

  //   test('Fetch All Games', () async {
  //     await database.transaction((txn) async {
  //       await gameTableHelper.insertGame(game3, txn);
  //       await gameTableHelper.insertGame(game4, txn);
  //     });

  //     final games = await gameTableHelper.fetchGames();
  //     expect(games.length, equals(2));
  //   });

  //   test('Delete Game', () async {
  //     await database.transaction((txn) async {
  //       await gameTableHelper.insertGame(game1, txn);
  //     });

  //     await gameTableHelper.deleteGame('game1');

  //     final fetchedGame = await gameTableHelper.fetchGame('game1');
  //     expect(fetchedGame, isNull);
  //   });

  //   test('Fetch Games by Player ID', () async {
  //     final player = GamePlayer(
  //       id: 'player1',
  //       playerId: 'player1',
  //       gameId: 'game6',
  //       name: 'Player 1',
  //       endRack: '',
  //       plays: [],
  //     );

  //     await database.transaction((txn) async {
  //       await gameTableHelper.insertGame(game5, txn);
  //       await txn.insert('game_players', player.toJson());
  //     });

  //     final games = await gameTableHelper.fetchGamesByPlayerId('player1');
  //     expect(games.length, equals(1));
  //   });
  // });

  tearDownAll(() async {
    await database.close();
  });
}
