import 'package:sqflite/sqflite.dart';
import '../../domain/models/database_helper.dart';
import 'game_players_table_helper.dart';
import 'games_table_helper.dart';
import 'played_letters_table_helper.dart';
import 'players_table_helper.dart';
import 'plays_table_helper.dart';
import 'words_table_helper.dart';

/// A helper class for calling the create methods
class MasterDatabaseHelper extends DatabaseHelper {
  final GameTableHelper _gameTableHelper = GameTableHelper();
  final GamePlayerTableHelper _gamePlayerTableHelper = GamePlayerTableHelper();
  final PlayerTableHelper _playerTableHelper = PlayerTableHelper();
  final PlayedLetterTableHelper _playedLetterTableHelper =
      PlayedLetterTableHelper();
  final PlayTableHelper _playTableHelper = PlayTableHelper();
  final WordTableHelper _wordsTableHelper = WordTableHelper();

  @override
  Future<void> createDB(Database db, int version) async {
    await _gameTableHelper.createDB(db, version);
    await _gamePlayerTableHelper.createDB(db, version);
    await _playerTableHelper.createDB(db, version);
    await _playedLetterTableHelper.createDB(db, version);
    await _playTableHelper.createDB(db, version);
    await _wordsTableHelper.createDB(db, version);
  }
}
