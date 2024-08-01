import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../gemini_coach/domain/models/stored_advice.dart';

/// The [LocalStorageService] class is responsible for handling secure storage
class LocalStorageService {
  /// The secure storage instance
  final FlutterSecureStorage secureStorage;

  /// Creates a new [LocalStorageService] instance
  LocalStorageService({required this.secureStorage});

  // Begin region: auth
  /// Deletes the stored authentication tokens
  Future<void> deleteAuthTokens() async {
    await secureStorage.delete(key: 'access_token');
    await secureStorage.delete(key: 'refresh_token');
  }

  /// Retrieves the stored access token from secure storage
  Future<String?> getAccessToken() async {
    final token = await secureStorage.read(key: 'access_token');

    return token;
  }

  /// Retrieves the stored refresh token from secure storage
  Future<String?> getRefreshToken() async {
    final token = await secureStorage.read(key: 'refresh_token');

    return token;
  }

  /// Saves the authentication tokens to secure storage
  Future<void> saveAuthTokens({
    String? accessToken,
    String? refreshToken,
  }) async {
    if (accessToken != null) {
      await secureStorage.write(key: 'access_token', value: accessToken);
    }
    if (refreshToken != null) {
      await secureStorage.write(key: 'refresh_token', value: refreshToken);
    }
  }

  // End region: auth
  // Begin region: advice
  /// Writes the advice to secure storage
  Future<void> saveAdvice(StoredAdvice advice) async {
    final adviceData = await _getAdviceData();
    adviceData[advice.playerId] = advice.toJson();

    final adviceJson = jsonEncode(adviceData);
    await secureStorage.write(key: 'advice', value: adviceJson);
  }

  Future<Map<String, dynamic>> _getAdviceData() async {
    final adviceJson = await secureStorage.read(key: 'advice');
    if (adviceJson != null) {
      return jsonDecode(adviceJson) as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  /// Retrieves the advice from secure storage
  Future<StoredAdvice?> getAdvice(String playerId) async {
    final adviceData = await _getAdviceData();
    if (adviceData.containsKey(playerId)) {
      return StoredAdvice.fromJson(adviceData[playerId]);
    } else {
      return null;
    }
  }

  // End region: advice
}
