import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/history_repository.dart';
import 'database_provider.dart';

/// A provider that controls interactions with the [HistoryRepository].
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  final databaseFuture = ref.watch(historyDatabaseProvider.future);
  return HistoryRepository(databaseFuture);
});
