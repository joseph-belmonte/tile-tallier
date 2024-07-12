// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../domain/models/player.dart';
// import 'history_repository_provider.dart';

// /// A provider that fetches a player by their ID.
// final playerProvider =
//     FutureProvider.family<Player, String>((ref, playerId) async {
//   final historyRepository = ref.watch(historyRepositoryProvider);
//   final db = await historyRepository.database;

//   return await db.transaction((txn) async {
//     return historyRepository.fetchPlayer(playerId, txn);
//   });


// });
