import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/database_helper.dart';

/// A provider that exposes a [DatabaseHelper] instance.
final wordListProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper.instance);
