// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:tile_tally/features/core/domain/models/game.dart';
// import 'package:tile_tally/features/core/domain/models/game_player.dart';
// import 'package:tile_tally/features/core/domain/models/letter.dart';
// import 'package:tile_tally/features/core/domain/models/play.dart';
// import 'package:tile_tally/features/core/domain/models/word.dart';
// import 'package:tile_tally/features/view_past_games/data/helpers/master_database_helper.dart';

// import 'package:tile_tally/features/view_past_games/domain/models/player.dart';
// import 'package:tile_tally/features/view_past_games/domain/repositories/history_repository.dart';
// import 'package:uuid/uuid.dart';

// Future<void> main() async {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   // Mocking the path_provider
//   TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
//       .setMockMethodCallHandler(
//     const MethodChannel('plugins.flutter.io/path_provider'),
//     (MethodCall methodCall) async => '.',
//   );

//   // Initialize FFI
//   sqfliteFfiInit();
//   databaseFactory = databaseFactoryFfi;

//   group('HistoryRepository tests', () {
//     late Database db; // Database instance
//     late Directory tempDir; // Temp directory used for testing
//     late HistoryRepository historyRepository;

//     setUp(() async {
//       tempDir = await Directory.systemTemp.createTemp('tile_tally');
//       final dbPath = '${tempDir.path}/game_database_test.db';

//       db = await openDatabase(
//         dbPath,
//         version: 1,
//         onCreate: (db, version) async {
//           await MasterDatabaseHelper.instance.testCreateDB(db, version);
//         },
//       );

//       MasterDatabaseHelper.testConstructor(db);
//       historyRepository = HistoryRepository();

//       final tables = await db
//           .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
//       print('Tables: $tables');
//     });

//     test('Insert a game with plays into the database and fetch it', () async {
//       final player1play = <Play>[
//         Play.createNew(gameId: Uuid().v4()).copyWith(
//           isBingo: true,
//           playedWords: [
//             Word.createNew().copyWith(
//               playedLetters: <Letter>[
//                 Letter.createNew(letter: 'O'),
//                 Letter.createNew(letter: 'N'),
//                 Letter.createNew(letter: 'E'),
//               ],
//             ),
//           ],
//         ),
//       ];

//       final player2play = <Play>[
//         Play.createNew(gameId: Uuid().v4()).copyWith(
//           isBingo: false,
//           playedWords: [
//             Word.createNew().copyWith(
//               playedLetters: <Letter>[
//                 Letter.createNew(letter: 'T'),
//                 Letter.createNew(letter: 'W'),
//                 Letter.createNew(letter: 'O'),
//               ],
//             ),
//           ],
//         ),
//       ];

//       final gameId = Uuid().v4();

//       final game = Game(
//         id: gameId,
//         players: [
//           GamePlayer(
//             id: Uuid().v4(),
//             gameId: gameId,
//             name: 'Player 1',
//             plays: player1play,
//             playerId: '',
//             endRack: '',
//           ),
//           GamePlayer(
//             id: Uuid().v4(),
//             gameId: gameId,
//             name: 'Player 2',
//             plays: player2play,
//             playerId: '',
//             endRack: '',
//           ),
//         ],
//         currentPlay: Play.createNew(gameId: gameId),
//         currentWord: Word.createNew(),
//       );

//       await db.transaction((txn) async {
//         await historyRepository.saveGame(game, txn);
//       });

//       final fetchedGames = await historyRepository.fetchGames();
//       final fetchedGame = fetchedGames.firstWhere((g) => g.id == game.id);

//       expect(fetchedGame.id, game.id);
//       expect(fetchedGame.players.length, game.players.length);
//       expect(fetchedGame.players.first.name, game.players.first.name);
//       expect(
//         fetchedGame.players.first.plays.length,
//         game.players.first.plays.length,
//       );
//       expect(fetchedGame.players.first.score, 53);
//       expect(fetchedGame.players.last.score, 6);
//     });

//     test('Delete a game from the database', () async {
//       final gameId = Uuid().v4();
//       final game = Game(
//         id: gameId,
//         players: <GamePlayer>[
//           GamePlayer(
//             id: Uuid().v4(),
//             gameId: gameId,
//             name: 'Player 1',
//             playerId: '',
//             plays: [],
//             endRack: '',
//           ),
//           GamePlayer(
//             id: Uuid().v4(),
//             gameId: gameId,
//             name: 'Player 2',
//             playerId: '',
//             plays: [],
//             endRack: '',
//           ),
//         ],
//         currentPlay: Play.createNew(gameId: gameId),
//         currentWord: Word.createNew(),
//       );

//       await db.transaction((txn) async {
//         await historyRepository.saveGame(game, txn);
//         await historyRepository.deleteGame(game.id);
//       });

//       final fetchedGames = await historyRepository.fetchGames();
//       expect(fetchedGames.any((g) => g.id == game.id), false);
//     });

//     test('Update player name in the database', () async {
//       final playerId = Uuid().v4();
//       const playerName = 'Old Name';
//       const newName = 'New Name';

//       final player = Player(id: playerId, name: playerName);
//       await historyRepository.insertPlayer(player);

//       await historyRepository.updatePlayerName(playerId, newName);

//       final players = await historyRepository.fetchAllPlayers();
//       final updatedPlayer = players.firstWhere((p) => p.id == playerId);

//       expect(updatedPlayer.name, newName);
//     });

//     tearDown(() async {
//       await db.close();
//       if (await tempDir.exists()) {
//         await tempDir.delete(recursive: true);
//       }
//     });
//   });
// }
