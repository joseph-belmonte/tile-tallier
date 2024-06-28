import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The [LocalStorageService] class is responsible for handling secure storage
class LocalStorageService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> deleteAuthTokens() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }

  Future<String?> getAccessToken() async {
    final token = await _secureStorage.read(key: 'access_token');

    return token;
  }

  Future<String?> getRefreshToken() async {
    final token = await _secureStorage.read(key: 'refresh_token');

    return token;
  }

  Future<void> saveAuthTokens({
    String? accessToken,
    String? refreshToken,
  }) async {
    if (accessToken != null) {
      await _secureStorage.write(key: 'access_token', value: accessToken);
    }
    if (refreshToken != null) {
      await _secureStorage.write(key: 'refresh_token', value: refreshToken);
    }
  }
}
