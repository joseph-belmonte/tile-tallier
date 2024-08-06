import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../enums/word_theme.dart';
import '../../../play_game/application/providers/word_db_repository.dart';

import '../../../shared/presentation/widgets/animate_flip_counter.dart';
import '../../../shared/presentation/widgets/loading_spinner.dart';

/// Displays the words for a given theme.
class WordListDisplayPage extends ConsumerStatefulWidget {
  /// The name of the theme to display words for.
  final String themeName;

  /// Creates a new [WordListDisplayPage] instance.
  const WordListDisplayPage({required this.themeName, super.key});

  @override
  ConsumerState<WordListDisplayPage> createState() =>
      _WordListDisplayPageState();
}

class _WordListDisplayPageState extends ConsumerState<WordListDisplayPage> {
  final TextEditingController controller = TextEditingController();
  List<String> filteredWords = [];
  int digitCount = 0;

  @override
  void initState() {
    super.initState();
    _loadWordList();
  }

  Future<void> _loadWordList() async {
    final wordDbRepository = ref.read(wordDatabaseProvider);
    final theme = getWordTheme(widget.themeName);
    final words = await wordDbRepository.getWordList(theme);
    setState(() {
      filteredWords = words;
      digitCount = words.length.toString().length;
    });
  }

  void _filterWords(String query) {
    final wordDbRepository = ref.read(wordDatabaseProvider);
    final theme = getWordTheme(widget.themeName);
    wordDbRepository.getWordList(theme).then((words) {
      setState(() {
        filteredWords =
            words.where((word) => word.contains(query.trim())).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final wordDbRepository = ref.read(wordDatabaseProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.themeName} Word List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              onChanged: _filterWords,
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search for a word',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Total Words: '),
                AnimatedFlipCounter(
                  value: filteredWords.length,
                  hideLeadingZeroes: true,
                  wholeDigits: digitCount,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future:
                  wordDbRepository.getWordList(getWordTheme(widget.themeName)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingSpinner();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No words found.'));
                } else {
                  return ListView.builder(
                    itemCount: filteredWords.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 2.0,
                        ),
                        title: Text('${index + 1}. ${filteredWords[index]}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
