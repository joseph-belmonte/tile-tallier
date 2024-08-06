import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tile_tally/features/play_game/data/helpers/word_database_helper.dart';

Future main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Mocking the path_provider
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/path_provider'),
    (MethodCall methodCall) async => '.',
  );

  // Initialize FFI
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('WordDatabaseHelper tests', () {
    late Database db; // Database instance
    late Directory tempDir; // Temp directory used for testing

    const testTableName = 'test_word_list';

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('tile_tally');
      final dbPath = '${tempDir.path}/word_db_test.db';

      db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
          return db.execute('''
          CREATE TABLE $testTableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            word TEXT NOT NULL
          )
        ''');
        },
      );

      WordListDBHelper.testConstructor(db);
    });

    test('Insert and query words', () async {
      await WordListDBHelper.instance.insert(
        row: {'word': 'hello'},
        tableName: testTableName,
      );
      await WordListDBHelper.instance.insert(
        row: {'word': 'world'},
        tableName: testTableName,
      );
      final rows = await WordListDBHelper.instance.queryAllRows(
        tableName: testTableName,
      );
      expect(rows, hasLength(2));
      expect(rows.first['word'], 'hello');
    });

    test('Delete all words', () async {
      await WordListDBHelper.instance.insert(
        row: {'word': 'world'},
        tableName: testTableName,
      );
      await WordListDBHelper.instance.deleteAll(tableName: testTableName);
      final rows = await WordListDBHelper.instance.queryAllRows(
        tableName: testTableName,
      );
      expect(rows, isEmpty);
    });

    tearDown(() async {
      await db.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });
  });
}
