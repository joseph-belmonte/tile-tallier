import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// An abstract class that provides helper methods for interacting with a database.
abstract class DatabaseHelper {
  Database? _database;

  /// Returns the database instance, initializing it if necessary.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('game_database.db');
    return _database!;
  }

  /// Initializes the database.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: createDB,
    );
  }

  /// Creates the database tables. This method should be overridden by subclasses.
  Future<void> createDB(Database db, int version);

  /// Closes the database.
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
