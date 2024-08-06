import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/helpers/word_database_helper.dart';

/// A provider that exposes a [WordListDBHelper] instance.
final wordListProvider =
    Provider<WordListDBHelper>((ref) => WordListDBHelper.instance);
