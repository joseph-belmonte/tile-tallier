/// A helper class for interacting with the 'plays' table in the database.
library;

import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import '../../../../utils/logger.dart';
import '../../../core/domain/models/play.dart';
import 'master_database_helper.dart';

/// A helper class for interacting with the 'plays' table in the database.
class PlayTableHelper {
  /// Inserts a play into the database.
  Future<void> insertPlay(Play play, Transaction txn) async {
    await txn.insert(
      'plays',
      {
        'id': play.id,
        'playerId': play.playerId,
        'gameId': play.gameId,
        'isBingo': play.isBingo ? 1 : 0,
        'timestamp': play.timestamp.toIso8601String(),
        'playedWords':
            jsonEncode(play.playedWords.map((word) => word.toJson()).toList()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all plays from the database.
  Future<List<Play>> fetchPlays({required String playerId}) async {
    final db = await MasterDatabaseHelper.instance.database;
    final playerPlaysMap =
        await db.query('plays', where: 'playerId = ?', whereArgs: [playerId]);

    final plays = <Play>[];

    for (var playMap in playerPlaysMap) {
      logger.d('playMap: $playMap');

      // Deserialize the main Play object
      final play = Play.fromJson(playMap);

      logger.d('play: $play');

      // Add the play to the list
      plays.add(play);
    }

    return plays;
  }

  /// Deletes all plays from the database by their game ID.
  Future<void> deletePlays({required String gameId}) async {
    final db = await MasterDatabaseHelper.instance.database;
    await db.delete('plays', where: 'gameId = ?', whereArgs: [gameId]);
  }
}
