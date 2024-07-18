import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/toast.dart';
import '../../controllers/pre_game_controller.dart';

/// Builds a list of input fields for player names.
class PlayerInputFields extends ConsumerWidget {
  /// Creates a new [PlayerInputFields] instance.
  const PlayerInputFields({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerCount = ref.watch(preGameProvider).playerCount;
    final controllers = ref.watch(preGameProvider).controllers;
    final activeFieldIndex = ref.watch(preGameProvider).activeFieldIndex;
    final hasError = ref.watch(preGameProvider).hasError;
    final playerNames = [];

    for (var i = 0; i < controllers.length; i++) {
      playerNames.add(controllers[i].text);
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: playerCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
          child: Column(
            children: <Widget>[
              Focus(
                onFocusChange: (hasFocus) {
                  if (hasFocus) {
                    // Ensure state updates happen outside of the build method
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref.read(preGameProvider.notifier).setActiveField(index);
                    });
                  }
                },
                child: ShakeX(
                  duration: Durations.medium1,
                  from: 40,
                  animate: activeFieldIndex == index && hasError,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controllers[index],
                    decoration: InputDecoration(
                      labelText: 'Player ${index + 1} Name',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          final name = controllers[index].text.trim();

                          if (name.isEmpty) return;

                          // Clear the text controller
                          controllers[index].clear();
                          ToastService.message(
                            context,
                            '$name removed from game',
                          );
                        },
                      ),
                    ),
                    validator: (value) {
                      // Ensure state updates happen outside of the build method
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final notifier = ref.read(preGameProvider.notifier);

                        if (value == null || value.isEmpty) {
                          notifier.setError(true);
                        } else {
                          final playerNames =
                              controllers.map((c) => c.text).toList();
                          if (playerNames.toSet().length !=
                              playerNames.length) {
                            notifier.setError(true);
                          } else {
                            notifier.setError(false);
                          }
                        }
                      });

                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      final playerNames =
                          controllers.map((c) => c.text).toList();
                      if (playerNames.toSet().length != playerNames.length) {
                        return 'Duplicate names are not allowed';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final notifier = ref.read(preGameProvider.notifier);
                      notifier.updatePlayerName(index, value);
                    },
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
