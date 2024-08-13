import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../play_game/data/helpers/word_database_helper.dart';
import '../../../shared/presentation/widgets/loading_spinner.dart';
import 'home.dart';

/// The splash screen to display during app initialization.
class SplashScreen extends StatefulWidget {
  /// Creates a new splash screen.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late WordListDBHelper _wordListDBHelper;
  late String word = '';

  @override
  void initState() {
    super.initState();
    _wordListDBHelper = WordListDBHelper.instance;
    _loadWordOfTheDay();

    // Delay by [Durations] before navigating to the home page
    Future.delayed(Durations.extralong1, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      );
    });
  }

  Future<void> _loadWordOfTheDay() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T').first;
    final savedDate = prefs.getString('wordOfTheDayDate');
    final savedWord = prefs.getString('wordOfTheDay');

    if (savedDate == today && savedWord != null) {
      // If the word of the day is already fetched for today, use it
      setState(() {
        word = savedWord;
      });
    } else {
      // Fetch a random word from the database
      final wordList = await _wordListDBHelper.queryAllRows(
        tableName: WordListDBHelper.defaultTable,
      );
      final randomWord = wordList.isNotEmpty
          ? wordList[Random().nextInt(wordList.length)]
              [WordListDBHelper.columnWord]
          : 'Flutter';

      // Save the word and date
      prefs.setString('wordOfTheDayDate', today);
      prefs.setString('wordOfTheDay', randomWord);

      setState(() {
        word = randomWord;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LoadingSpinner(),
            SizedBox(height: 40),
            Text(
              'Welcome to TileTallier',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            if (word.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'The word of the day is',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            if (word.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  word,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
