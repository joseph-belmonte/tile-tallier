import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/word_database_helper.dart';

/// A provider that exposes a [WordDatabaseHelper] instance.
final wordListProvider = Provider<WordDatabaseHelper>((ref) => WordDatabaseHelper.instance);
