import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../history/application/providers/history_repository_provider.dart';
import '../../../history/domain/models/player.dart';
import '../../../history/domain/repositories/history_repository.dart';

/// Manages the state of the pre-game screen.
class PreGameState {
  /// The number of players.
  final int playerCount;

  /// The text controllers for the player names.
  final List<TextEditingController> controllers;

  /// Whether a player can be added.
  final bool canAdd;

  /// Whether a player can be removed.
  final bool canRemove;

  /// Whether the user can navigate to the next screen.
  final bool canNavigate;

  /// Known players
  final List<Player> knownPlayers;

  /// Selected players
  final List<String> selectedPlayers;

  /// Designates the active field index.
  final int? activeFieldIndex; // Nullable to indicate no field is active

  /// Creates a new [PreGameState] instance.
  PreGameState({
    required this.playerCount,
    required this.controllers,
    required this.canAdd,
    required this.canRemove,
    required this.canNavigate,
    required this.knownPlayers,
    required this.selectedPlayers,
    this.activeFieldIndex,
  });

  /// Creates a copy of the state with the given changes.
  PreGameState copyWith({
    int? playerCount,
    List<TextEditingController>? controllers,
    bool? canAdd,
    bool? canRemove,
    bool? canNavigate,
    List<Player>? knownPlayers,
    List<String>? selectedPlayers,
    int? activeFieldIndex,
  }) {
    return PreGameState(
      playerCount: playerCount ?? this.playerCount,
      controllers: controllers ?? this.controllers,
      canAdd: canAdd ?? this.canAdd,
      canRemove: canRemove ?? this.canRemove,
      canNavigate: canNavigate ?? this.canNavigate,
      knownPlayers: knownPlayers ?? this.knownPlayers,
      selectedPlayers: selectedPlayers ?? this.selectedPlayers,
      activeFieldIndex: activeFieldIndex ?? this.activeFieldIndex,
    );
  }
}

/// A provider that manages the state of the pre-game screen.
class PreGamePageController extends StateNotifier<PreGameState> {
  final HistoryRepository _historyRepository;

  /// Creates a new [PreGamePageController] instance.
  PreGamePageController(this._historyRepository)
      : super(
          PreGameState(
            playerCount: 2,
            controllers: List.generate(2, (index) => TextEditingController()),
            canAdd: true,
            canRemove: false,
            canNavigate: false,
            knownPlayers: [],
            selectedPlayers: [],
            activeFieldIndex: null,
          ),
        ) {
    fetchKnownPlayers();
  }

  /// Fetches all players from the database.
  Future<void> fetchKnownPlayers() async {
    final players = await _historyRepository.fetchAllPlayers();
    state = state.copyWith(knownPlayers: players);
  }

  /// Selects a player.
  void selectPlayer(String playerName) {
    if (state.activeFieldIndex != null) {
      final index = state.activeFieldIndex!;
      state.controllers[index].text = playerName;
      state = state.copyWith(activeFieldIndex: null);
      if (!state.selectedPlayers.contains(playerName)) {
        final updatedPlayers = [...state.selectedPlayers, playerName];
        state = state.copyWith(selectedPlayers: updatedPlayers);
      }
    }
  }

  /// Deselects a player.
  void deselectPlayer(String playerName) {
    if (state.selectedPlayers.contains(playerName)) {
      final updatedPlayers =
          state.selectedPlayers.where((name) => name != playerName).toList();
      state = state.copyWith(selectedPlayers: updatedPlayers);
    }
  }

  /// Sets the active field index.
  void setActiveField(int index) {
    state = state.copyWith(activeFieldIndex: index);
  }

  /// Clears the active field index.
  void clearActiveField() {
    state = state.copyWith(activeFieldIndex: null);
  }

  /// Updates the text controllers based on the player count.
  void updateControllers() {
    final neededControllers = state.playerCount - state.controllers.length;
    if (neededControllers > 0) {
      state = state.copyWith(
        controllers: List.from(state.controllers)
          ..addAll(
            List.generate(
              neededControllers,
              (index) => TextEditingController(),
            ),
          ),
      );
    } else if (neededControllers < 0) {
      state.controllers
          .getRange(state.playerCount, state.controllers.length)
          .forEach((c) => c.dispose());
      state = state.copyWith(
        controllers: List.from(state.controllers)
          ..removeRange(state.playerCount, state.controllers.length),
      );
    }
  }

  /// Increments the player count.
  void addToPlayerCount() {
    if (state.playerCount < 4) {
      state = state.copyWith(
        playerCount: state.playerCount + 1,
        canAdd: state.playerCount + 1 < 4,
        canRemove: true,
      );
      updateControllers();
    }
  }

  /// Decrements the player count.
  void removeFromPlayerCount() {
    if (state.playerCount > 2) {
      state = state.copyWith(
        playerCount: state.playerCount - 1,
        canRemove: state.playerCount - 1 > 2,
        canAdd: true,
      );
      updateControllers();
    }
  }

  /// Updates the player name at the given index.
  void updatePlayerName(int index, String name) {
    final updatedControllers =
        List<TextEditingController>.from(state.controllers);
    updatedControllers[index].text = name;
    state = state.copyWith(controllers: updatedControllers);
  }

  /// Starts the game.
  void startGame() {
    final playerNames = state.controllers
        .map((controller) => controller.text.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    if (playerNames.isNotEmpty) {
      state = state.copyWith(canNavigate: true);
    } else {
      state = state.copyWith(canNavigate: false);
    }
  }

  /// Sets the navigation state to false.
  void resetNavigation() {
    state = state.copyWith(canNavigate: false);
  }

  /// Clears the text controllers.
  void clearControllers() {
    for (var controller in state.controllers) {
      controller.clear();
    }
  }

  /// Re-initializes the text controllers for a new game.
  void initializeControllers() {
    for (var controller in state.controllers) {
      controller.dispose();
    }
    state = PreGameState(
      playerCount: 2,
      controllers: List.generate(2, (index) => TextEditingController()),
      canAdd: true,
      canRemove: false,
      canNavigate: false,
      knownPlayers: state.knownPlayers,
      selectedPlayers: state.selectedPlayers,
    );
  }

  /// Gets the player count.
  int get playerCount => state.playerCount;

  /// Exposes the text controllers
  List<TextEditingController> get controllers => state.controllers;

  /// Exposes the active field index.
  int? get activeFieldIndex => state.activeFieldIndex;

  /// Gets the list of player names.
  List<String> get playerNames =>
      state.controllers.map((controller) => controller.text.trim()).toList();
}

/// A provider that exposes the [PreGamePageController].
final preGameProvider =
    StateNotifierProvider<PreGamePageController, PreGameState>((ref) {
  return PreGamePageController(ref.watch(historyRepositoryProvider));
});
