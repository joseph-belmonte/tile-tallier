// ignore_for_file: comment_references

import 'used_key_value_db.dart';

/// App name and info constants.
class AppDb {
  /// This class is not meant to be instantiated or extended; this constructor
  /// prevents instantiation and extension.
  AppDb._();

  /// Default used [KeyValueDb] implementation.
  static const UsedKeyValueDb keyValue = UsedKeyValueDb.sharedPreferences;
}
