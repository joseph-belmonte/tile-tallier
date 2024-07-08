import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/past_game_repository.dart';

/// A provider that exposes the PastGameRepository.
final pastGameRepositoryProvider = Provider<PastGameRepository>((ref) {
  return PastGameRepository();
});
