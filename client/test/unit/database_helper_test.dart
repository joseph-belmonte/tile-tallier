import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrabble_scorer/utils/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Mocking the path_provider
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/path_provider'),
    (MethodCall methodCall) async => '.',
  );

  // Initialize FFI
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('DatabaseHelper tests', () {
    late Database db; // Database instance
    late Directory tempDir; // Temp directory used for testing

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('scrabble_scorer');
      final dbPath = '${tempDir.path}/test.db';

      db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
          return db.execute('''
          CREATE TABLE word_list (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            word TEXT NOT NULL
          )
        ''');
        },
      );

      DatabaseHelper.testConstructor(db);
    });

    test('Insert and query words', () async {
      await DatabaseHelper.instance.insert({'word': 'hello'});
      await DatabaseHelper.instance.insert({'word': 'world'});
      final rows = await DatabaseHelper.instance.queryAllRows();
      expect(rows, hasLength(2));
      expect(rows.first['word'], 'hello');
    });

    test('Delete all words', () async {
      await DatabaseHelper.instance.insert({'word': 'world'});
      await DatabaseHelper.instance.deleteAll();
      final rows = await DatabaseHelper.instance.queryAllRows();
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
