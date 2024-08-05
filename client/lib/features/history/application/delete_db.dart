import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// The name of the database file to delete.
// const deletedDb = 'game_database.db';
const deletedDb = 'word_database.db';

/// Deletes the [deletedDb] database file.
Future<void> deleteDatabaseFile() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, deletedDb);
  final file = File(path);

  if (await file.exists()) {
    await file.delete();
  }
}
