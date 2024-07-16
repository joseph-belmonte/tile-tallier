import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/app_db.dart';
import '../../domain/models/used_key_value_db.dart';

/// A [StateProvider] controller used to control which [KeyValueDb]
/// implementation is used.
///
/// Used by UI widgets to select used [KeyValueDb] implementation.
final StateProvider<UsedKeyValueDb> usedKeyValueDbProvider =
    StateProvider<UsedKeyValueDb>(
  (final StateProviderRef<UsedKeyValueDb> ref) => AppDb.keyValue,
  name: 'usedKeyValueDbProvider',
);
