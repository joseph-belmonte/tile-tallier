import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/history_repository.dart';

/// A provider that controls interactions with the [HistoryRepository].
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository();
});
