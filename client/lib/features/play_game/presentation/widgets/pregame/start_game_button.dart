// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class StartGameButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;

  const StartGameButton({
    required this.formKey,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton.icon(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            onPressed();
          }
        },
        icon: const Icon(Icons.play_arrow_rounded, semanticLabel: 'start game'),
        label: const Text('Start Game'),
      ),
    );
  }
}
