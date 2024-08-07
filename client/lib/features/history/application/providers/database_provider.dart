import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../../../shared/data/helpers/master_database_helper.dart';

/// Exposes a provider that fetches the database.
final historyDatabaseProvider = FutureProvider<Database>((ref) async {
  return await MasterDatabaseHelper.instance.database;
});
