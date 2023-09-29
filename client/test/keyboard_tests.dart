// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter_test/flutter_test.dart';
// import 'package:provider/provider.dart';

// import 'package:scrabble_scorer/widgets/keyboard.dart';
// import 'package:scrabble_scorer/providers/active_game.dart';
// import 'package:scrabble_scorer/providers/active_play.dart';
// import 'package:scrabble_scorer/routes/tabs.dart';
// import 'package:scrabble_scorer/widgets/scrabble_tile.dart';

// void main() {
//   testWidgets('Button keyboard types', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider<ActiveGame>(
//             create: (context) => ActiveGame(),
//           ),
//           ChangeNotifierProvider<ActivePlay>(
//             create: (context) => ActivePlay(),
//           ),
//           ChangeNotifierProvider<AppState>(
//             create: (context) => AppState(),
//           ),
//         ],
//         child: const GameView(),
//       ),
//     );

//     // Click the letters P O O L on the keyboard
//     await tester.tap(find.widgetWithText(KeyboardKey, 'P'));
//     await tester.tap(find.widgetWithText(KeyboardKey, 'O'));
//     await tester.tap(find.widgetWithText(KeyboardKey, 'O'));
//     await tester.tap(find.widgetWithText(KeyboardKey, 'L'));

//     // Verify that:
//     // - the first player has a "staged" word whose characters are POOL
//     expect(find.byType(ScrabbleWordWidget), findsOneWidget);
//   });

//   // testWidgets('Native keyboard types', (WidgetTester tester) async {
//   //   // Build our app and trigger a frame.
//   //   await tester.pumpWidget(
//   //     MultiProvider(
//   //       providers: [
//   //         ChangeNotifierProvider<ActiveGame>(
//   //           create: (context) => ActiveGame(),
//   //         ),
//   //         ChangeNotifierProvider<CurrentPlayState>(
//   //           create: (context) => CurrentPlayState(),
//   //         ),
//   //         ChangeNotifierProvider<AppState>(
//   //           create: (context) => AppState(),
//   //         ),
//   //       ],
//   //       child: const GameView(),
//   //     ),
//   //   );

//   //   // navigate to the settings tab and select the device keyboard
//   //   await tester.tap(find.widgetWithText(Tab, 'Settings'));

//   //   // Create the Finders.
//   //   final tileFinder = find.text('Keyboard');

//   //   await tester.tap(tileFinder);
//   //   await tester.tap(find.widgetWithText(SettingsTile, 'Device Keyboard'));

//   //   // navigate back to the game tab
//   //   await tester.tap(find.widgetWithText(Tab, 'Scores'));

//   //   // click in the input box
//   //   await tester.tap(find.byType(TextField));

//   //   // type the word POOL
//   //   await tester.enterText(find.byType(TextField), 'POOL');
//   //   expect(find.byType(ScrabbleWordWidget), findsOneWidget);

//   //   // Verify that:
//   //   // - the first player has a "staged" word whose characters are POOL
//   //   expect(find.byType(ScrabbleWordWidget), findsOneWidget);
//   // });
// }
