/// Enum for themed word gameplay
enum WordTheme {
  /// Default ENABLE word list
  basic(
    'No Theme',
    'Words from the Enable word list.',
    'assets/txt/word_list.txt',
  ),

  /// Avain word list
  avian(
    'Avian',
    'Words related to birds!',
    'assets/txt/avian_list.txt',
  ),

  /// Wordle word list
  wordle(
    'Wordle',
    'Words from the popular game Wordle.',
    'assets/txt/wordle_list.txt',
  ),

  /// Family word list
  family(
    'Family',
    'Words related to family and relationships',
    'assets/txt/family_list.txt',
  ),

  /// Naval word list
  maritime(
    'Maritime',
    'Words related to the naval vessels',
    'assets/txt/maritime_list.txt',
  ),

  /// Arbor word list
  arbor(
    'Arbor',
    'Words related to trees and forests',
    'assets/txt/arbor_list.txt',
  );

  const WordTheme(this.name, this.description, this.path);

  /// The display name of the word theme
  final String name;

  /// The description of the word theme
  final String description;

  /// The filepath of the word list
  final String path;
}

/// Accepts a text and returns the [WordTheme] to use.
WordTheme getWordTheme(String themeName) {
  for (var theme in WordTheme.values) {
    if (theme.name == themeName) {
      return theme;
    }
  }
  return WordTheme.basic;
}
