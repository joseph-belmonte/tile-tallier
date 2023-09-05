// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/current_game_state.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';
import 'package:scrabble_scorer/scrabble_tile.dart';
import 'package:scrabble_scorer/keyboard.dart';
import 'package:scrabble_scorer/writing_zone.dart';

void main() {
  testWidgets('Button keyboard types', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CurrentGameState>(
            create: (context) => CurrentGameState(),
          ),
          ChangeNotifierProvider<CurrentPlayState>(
            create: (context) => CurrentPlayState(),
          ),
          ChangeNotifierProvider<AppState>(
            create: (context) => AppState(),
          ),
        ],
        child: const ScrabbleScorer(),
      ),
    );

    // Click the letters P O O L on the keyboard
    await tester.tap(find.widgetWithText(KeyboardKey, 'P'));
    await tester.tap(find.widgetWithText(KeyboardKey, 'O'));
    await tester.tap(find.widgetWithText(KeyboardKey, 'O'));
    await tester.tap(find.widgetWithText(KeyboardKey, 'L'));

    // Verify that:
    // - the first player has a "staged" word whose characters are POOL
    expect(find.byType(ScrabbleWordWidget), findsOneWidget);
  });
}
