import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/word_db_repository.dart';

/// A provider that controls interactions with the [WordDatabaseHeloer].
final wordDatabaseProvider = Provider<WordDbRepository>((ref) {
  return WordDbRepository();
});
