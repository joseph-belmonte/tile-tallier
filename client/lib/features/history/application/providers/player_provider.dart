// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../domain/models/player.dart';
// import 'history_repository_provider.dart';

// /// A provider that fetches a player by their ID.
// final playerProvider =
//     FutureProvider.family<Player, String>((ref, playerId) async {
//   final historyRepository = ref.watch(historyRepositoryProvider);
//   final db = await historyRepository.database;

//   await db.transaction((txn) {

//   final player = await historyRepository.fetchPlayer(playerId);

//   });

//   if (player == null) {
//     throw Exception('Player not found');
//   }
//   return player;
// });
