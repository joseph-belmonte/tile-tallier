import 'key_value_db.dart';

import 'key_value_db_prefs.dart';

/// An enhanced enum used to represent, select and describe the used
/// [KeyValueDb] implementation.
enum UsedKeyValueDb {
  /// Shared Preferences implementation.
  sharedPreferences();

  const UsedKeyValueDb();

  /// Get the [KeyValueDb] implementation corresponding to the enum value.
  KeyValueDb get get {
    switch (this) {
      case UsedKeyValueDb.sharedPreferences:
        return KeyValueDbPrefs();
      default:
        return KeyValueDbPrefs();
    }
  }

  /// Describe the [KeyValueDb] implementation corresponding to the enum value.
  String get describe {
    switch (this) {
      case UsedKeyValueDb.sharedPreferences:
        return 'Shared Preferences';
      default:
        return 'Shared Preferences';
    }
  }
}
