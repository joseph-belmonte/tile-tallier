import 'package:flutter/material.dart';
import 'package:scrabble_scorer/display_zone.dart';
import 'package:scrabble_scorer/writing_zone.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({required this.title, super.key});
  final String title;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ListView(
          children: const [
            DisplayZone(),
            WritingZone(),
          ],
        ),
      ),
    );
  }
}
