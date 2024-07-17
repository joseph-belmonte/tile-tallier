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
                    ref.read(preGameProvider.notifier).setActiveField(index);
                  }
                },
                child: TextFormField(
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
                    return (value == null || value.trim().isEmpty)
                        ? 'Please enter a name'
                        : null;
                  },
                  onChanged: (value) {
                    final notifier = ref.read(preGameProvider.notifier);
                    final hasKnownPlayers = notifier.knownPlayers.isNotEmpty;
                    final nameMatches = controllers
                        .any((controller) => controller.text == value);

                    var alreadyUsed = false;
                    for (var i = 0; i < controllers.length; i++) {
                      if (i != index && controllers[i].text == value) {
                        alreadyUsed = true;
                        break;
                      }
                    }

                    if (hasKnownPlayers) {
                      if (nameMatches || alreadyUsed) {
                        ToastService.error(context, 'Player already selected');
                      }
                    } else {
                      notifier.updatePlayerName(index, value);
                    }
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
