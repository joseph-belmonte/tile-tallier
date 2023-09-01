// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

void main() {
  testWidgets('Word submits smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ScrabbleScorer());

    // Verify that our beginning playedWordState is empty.
    expect(find.text(''), findsOneWidget);

    // Click the letters P O O L on the keyboard
    await tester.tap(find.text('P'));
    await tester.tap(find.text('O'));
    await tester.tap(find.text('O'));
    await tester.tap(find.text('L'));

    // Click on P in the playedWord to trigger a double letter score
    await tester.tap(find.text('P'));
    // Click the toggle multiplier button to trigger a double word score
    await tester.tap(find.byIcon(Icons.multiple_stop_rounded));
    // Click the submit button to play the word
    await tester.tap(find.byIcon(Icons.add_circle_outline));
    // Click the end turn button to switch players
    await tester.tap(find.byIcon(Icons.switch_account_rounded));

    // Verify that:
    // - the first player has a play whose playedWords is POOL
    expect(find.text('POOL'), findsOneWidget);
    // - the first player has a play whose score is 18
    expect(find.text('POOL'), findsOneWidget);
    // - the first and second player have a turn label
    expect(find.text('Turn 1:'), findsWidgets);
    // - the first player has a score of 18
    expect(find.text('Turn 1:18'), findsOneWidget);
    // - the second player has no score
    expect(find.text('Turn 1:0'), findsOneWidget);
  });
}
