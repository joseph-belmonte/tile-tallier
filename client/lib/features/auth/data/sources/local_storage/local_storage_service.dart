import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The [LocalStorageService] class is responsible for handling secure storage
class LocalStorageService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Delete the access and refresh tokens from the secure storage.
  Future<void> deleteAuthTokens() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }

  /// Fetch the access token from the secure storage.
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  /// Fetch the refresh token from the secure storage.
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  /// Save the access and refresh tokens to the secure storage.
  Future<void> saveAuthTokens({
    String? accessToken,
    String? refreshToken,
  }) async {
    if (accessToken != null) {
      await _secureStorage.write(key: 'access_token', value: accessToken);
    }
    if (refreshToken != null) {
      await _secureStorage.write(key: 'refresh', value: refreshToken);
    }
  }
}
