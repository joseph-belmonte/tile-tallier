// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Builds a list of input fields for player names.
class PlayerInputFields extends StatelessWidget {
  final int playerCount;
  final List<TextEditingController> controllers;
  final Function(int, String) onPlayerNameChange;

  const PlayerInputFields({
    required this.playerCount,
    required this.controllers,
    required this.onPlayerNameChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: playerCount,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
        child: TextFormField(
          controller: controllers[index],
          decoration: InputDecoration(labelText: 'Player ${index + 1} Name'),
          validator: (value) => (value == null || value.trim().isEmpty)
              ? 'Please enter a name'
              : null,
          onChanged: (value) => onPlayerNameChange(index, value),
        ),
      ),
    );
  }
}
