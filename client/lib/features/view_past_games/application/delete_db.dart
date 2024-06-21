import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../utils/logger.dart';

/// Deletes the database file.
Future<void> deleteDatabaseFile() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'game_database.db');
  final file = File(path);

  if (await file.exists()) {
    await file.delete();
    logger.i('Database file deleted');
  } else {
    logger.i('Database file does not exist');
  }
}
