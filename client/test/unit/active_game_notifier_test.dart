import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tile_tally/features/play_game/application/providers/active_game.dart';
import 'package:tile_tally/features/play_game/domain/models/game_player.dart';
import 'package:tile_tally/features/play_game/domain/models/play.dart';
import 'package:uuid/uuid.dart';

void main() {
  ProviderContainer createContainer() {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    return container;
  }

  group('ActiveGameNotifier Tests', () {
    test('Initial state is correct', () {
      final container = createContainer();
      final initialState = container.read(activeGameProvider);

      expect(initialState.players.isEmpty, true);
      expect(initialState.currentPlayerIndex, 0);
      expect(initialState.currentPlay, isNotNull);
      expect(initialState.currentWord, isNotNull);
    });

    test('Validate startGame', () {
      final container = createContainer();
      final activeGameNotifier = container.read(activeGameProvider.notifier);

      activeGameNotifier.startGame(['Andrea', 'Joe']);

      final updatedState = container.read(activeGameProvider);
      expect(updatedState.players.length, equals(2));
      expect(updatedState.players[0].name, equals('Andrea'));
      expect(updatedState.players[1].name, equals('Joe'));
    });

    test('Validate updatePlayers', () {
      final container = createContainer();
      final activeGameNotifier = container.read(activeGameProvider.notifier);

      final dummyPlay = Play(
        id: Uuid().v4(),
        timestamp: DateTime.now(),
      );

      final newPlayers = [
        Player(name: 'Andrea', id: Uuid().v4(), plays: [dummyPlay]),
        Player(name: 'Joe', id: Uuid().v4()),
      ];
      activeGameNotifier.updatePlayers(newPlayers);

      final updatedState = container.read(activeGameProvider);
      expect(updatedState.players.length, equals(2));
      expect(updatedState.players[0].name, equals('Andrea'));
      expect(updatedState.players[0].plays.length, equals(1));
      expect(updatedState.players[1].name, equals('Joe'));
    });

    test('validate endTurn', () {
      final container = createContainer();
      final activeGameNotifier = container.read(activeGameProvider.notifier);

      final newPlayers = [
        Player(name: 'Andrea', id: Uuid().v4()),
        Player(name: 'Joe', id: Uuid().v4()),
      ];

      activeGameNotifier.updatePlayers(newPlayers);

      final updatedState = container.read(activeGameProvider);
      expect(updatedState.players.length, equals(2));
      expect(updatedState.players[0].name, equals('Andrea'));
      expect(updatedState.players[1].name, equals('Joe'));

      activeGameNotifier.endTurn();

      final updatedState2 = container.read(activeGameProvider);
      expect(updatedState2.players[0].plays.length, equals(1));
      expect(updatedState2.players[1].plays.length, equals(0));
      expect(updatedState2.currentPlayerIndex, equals(1));
      expect(
        updatedState2.currentPlay.playerId,
        equals(updatedState2.players[1].id),
      );
      expect(updatedState2.currentWord, isNotNull);
      expect(updatedState2.currentWord.word.isEmpty, true);
    });

    test('validate undoTurn', () {
      final container = createContainer();
      final activeGameNotifier = container.read(activeGameProvider.notifier);

      final newPlayers = [
        Player(name: 'Andrea', id: Uuid().v4()),
        Player(name: 'Joe', id: Uuid().v4()),
      ];

      activeGameNotifier.updatePlayers(newPlayers);

      final updatedState = container.read(activeGameProvider);
      expect(updatedState.players.length, equals(2));
      expect(updatedState.players[0].name, equals('Andrea'));
      expect(updatedState.players[1].name, equals('Joe'));

      activeGameNotifier.endTurn();

      activeGameNotifier.undoTurn();

      final updatedState2 = container.read(activeGameProvider);
      expect(updatedState2.players[0].plays.length, equals(0));
      expect(updatedState2.players[1].plays.length, equals(0));
      expect(updatedState2.currentPlayerIndex, equals(0));
      expect(
        updatedState2.currentPlay.playerId,
        equals(updatedState2.players[0].id),
      );
      expect(updatedState2.currentWord, isNotNull);
      expect(updatedState2.currentWord.word.isEmpty, true);
    });
  });
}
