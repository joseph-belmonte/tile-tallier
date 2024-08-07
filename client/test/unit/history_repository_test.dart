import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tile_tally/features/history/domain/models/player.dart';
import 'package:tile_tally/features/history/domain/repositories/history_repository.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockDatabase mockDatabase;
  late MockTransaction mockTransaction;
  late HistoryRepository historyRepository;

  setUp(() {
    mockDatabase = MockDatabase();
    mockTransaction = MockTransaction();
    historyRepository = HistoryRepository(Future.value(mockDatabase));

    when(mockDatabase.transaction(any)).thenAnswer((invocation) async {
      final transactionCallback = invocation.positionalArguments[0]
          as Future<void> Function(Transaction);
      await transactionCallback(mockTransaction);
      return null;
    });
  });

  group('Tests for the player methods of the history repository', () {
    test('should save a player', () async {
      final player =
          Player(name: 'John Doe', id: 'e4b68ee4-0953-4002-b7b5-8a8c0e03c6ab');

      when(mockDatabase.transaction(any)).thenAnswer((invocation) async {
        final transactionCallback = invocation.positionalArguments[0]
            as Future<void> Function(Transaction);
        await transactionCallback(mockTransaction);
        return null;
      });

      when(
        mockTransaction.insert(
          any,
          any,
          conflictAlgorithm: anyNamed('conflictAlgorithm'),
        ),
      ).thenAnswer((_) async => 1);

      await historyRepository.savePlayer(mockTransaction, player);

      verify(
        mockTransaction.insert(
          'players',
          player.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).called(1);
    });

    test('should fetch a player by ID', () async {
      final player =
          Player(name: 'John Doe', id: 'e4b68ee4-0953-4002-b7b5-8a8c0e03c6ab');
      const playerId = 'e4b68ee4-0953-4002-b7b5-8a8c0e03c6ab';

      when(mockDatabase.transaction(any)).thenAnswer((invocation) async {
        final transactionCallback = invocation.positionalArguments[0]
            as Future<void> Function(Transaction);
        await transactionCallback(mockTransaction);
        return null;
      });

      when(
        mockTransaction.query(
          'players',
          where: 'id = ?',
          whereArgs: [playerId],
        ),
      ).thenAnswer((_) async => [player.toJson()]);

      final fetchedPlayer = await historyRepository.fetchPlayer(
        txn: mockTransaction,
        playerId: playerId,
      );

      expect(fetchedPlayer, isNotNull);
      expect(fetchedPlayer!.id, equals(player.id));
      expect(fetchedPlayer.name, equals(player.name));
    });
  });
}
