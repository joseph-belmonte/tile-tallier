import 'package:flutter/material.dart';

/// A styled cancel button for use in modal dialogs.
class CancelButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// The function to call when the button is pressed.
  final void Function() onPressed;

  /// Creates a new [CancelButton] instance.
  const CancelButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
    );
  }
}
