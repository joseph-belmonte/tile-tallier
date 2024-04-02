import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/drawer_width.dart';

/// A provider that provides the drawer width.
final StateProvider<num> drawerWidthProvider = StateProvider<num>((StateProviderRef<num> ref) {
  return drawerWidth();
});
