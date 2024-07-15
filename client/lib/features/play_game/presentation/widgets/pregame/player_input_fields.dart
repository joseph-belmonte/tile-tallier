// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/toast.dart';
import '../../controllers/pre_game_controller.dart';

/// Builds a list of input fields for player names.
class PlayerInputFields extends ConsumerWidget {
  const PlayerInputFields({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ref.read(preGameProvider).playerCount,
      itemBuilder: (context, index) => Padding(
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
                controller: ref.read(preGameProvider).controllers[index],
                decoration: InputDecoration(
                  labelText: 'Player ${index + 1} Name',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      ref.read(preGameProvider).controllers[index].clear();
                    },
                  ),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Please enter a name'
                    : null,
                onChanged: (value) {
                  if (ref
                      .read(preGameProvider.notifier)
                      .playerNames
                      .contains(value)) {
                    ToastService.error(context, 'Player already selected');
                  } else {
                    ref
                        .read(preGameProvider.notifier)
                        .updatePlayerName(index, value);
                  }
                },
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
