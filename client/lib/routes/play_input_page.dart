import 'package:flutter/material.dart';
import 'package:scrabble_scorer/display_zone.dart';
import 'package:scrabble_scorer/writing_zone.dart';

class PlayInputPage extends StatelessWidget {
  const PlayInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [DisplayZone(), WritingZone()]);
  }
}
