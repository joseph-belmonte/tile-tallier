import 'package:flutter/material.dart';
import 'package:scrabble_scorer/display_zone.dart';
import 'package:scrabble_scorer/writing_zone.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [DisplayZone(), WritingZone()]);
  }
}
