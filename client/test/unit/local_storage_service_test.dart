import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tile_tally/features/auth/data/sources/local_storage/local_storage_service.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late LocalStorageService localStorageService;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    localStorageService = LocalStorageService(secureStorage: mockSecureStorage);
  });

  group('LocalStorageService', () {
    WidgetsFlutterBinding.ensureInitialized();

    test('saveAuthTokens saves tokens to secure storage', () async {
      const accessToken = 'access_token';
      const refreshToken = 'refresh_token';

      await localStorageService.saveAuthTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      verify(mockSecureStorage.write(key: 'access_token', value: accessToken))
          .called(1);
      verify(mockSecureStorage.write(key: 'refresh_token', value: refreshToken))
          .called(1);
    });

    test('getAccessToken retrieves the access token from secure storage',
        () async {
      const accessToken = 'access_token';
      when(mockSecureStorage.read(key: 'access_token'))
          .thenAnswer((_) async => accessToken);

      final token = await localStorageService.getAccessToken();

      expect(token, accessToken);
    });

    test('getRefreshToken retrieves the refresh token from secure storage',
        () async {
      const refreshToken = 'refresh_token';
      when(mockSecureStorage.read(key: 'refresh_token'))
          .thenAnswer((_) async => refreshToken);

      final token = await localStorageService.getRefreshToken();

      expect(token, refreshToken);
    });

    test('deleteAuthTokens deletes tokens from secure storage', () async {
      await localStorageService.deleteAuthTokens();

      verify(mockSecureStorage.delete(key: 'access_token')).called(1);
      verify(mockSecureStorage.delete(key: 'refresh_token')).called(1);
    });
  });
}
