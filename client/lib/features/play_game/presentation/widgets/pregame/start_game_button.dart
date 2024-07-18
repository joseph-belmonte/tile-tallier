// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/toast.dart';
import '../../controllers/pre_game_controller.dart';

class StartGameButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;

  const StartGameButton({
    required this.formKey,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton.icon(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ref.read(preGameProvider).hasError = false;
            onPressed();
          } else {
            ref.read(preGameProvider).hasError = true;
            ToastService.error(context, 'Please review name fields');
          }
        },
        icon: const Icon(Icons.play_arrow_rounded, semanticLabel: 'start game'),
        label: const Text('Start Game'),
      ),
    );
  }
}
