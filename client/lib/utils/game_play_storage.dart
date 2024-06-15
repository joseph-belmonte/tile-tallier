import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class to store and retrieve gameplay data.
class GamePlayStorage {
  static const _lastPlayDateKey = 'last_play_date';

  /// Whether the user has played today.
  static Future<bool> hasPlayedToday() async {
    final prefs = await SharedPreferences.getInstance();
    final lastPlayDate = prefs.getString(_lastPlayDateKey);
    if (lastPlayDate == null) {
      return false;
    }
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return lastPlayDate == today;
  }

  /// Sets the last play date to today.
  static Future<void> setPlayedToday() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await prefs.setString(_lastPlayDateKey, today);
  }
}
