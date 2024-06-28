import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tile_tally/features/auth/application/providers/auth_provider.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late FlutterSecureStorage realSecureStorage;
  late AuthNotifier authNotifier;

  setUp(() {
    mockAuthService = MockAuthService();
    realSecureStorage = FlutterSecureStorage();
    authNotifier = AuthNotifier(mockAuthService);
  });

  group('AuthNotifier', () {
    test('login - success', () async {
      const email = 'test@example.com';
      const password = 'password';
      final userJson = {
        'access': 'access_token',
        'refresh': 'refresh_token',
        'user': {'email': email, 'is_subscribed': true},
      };

      // Define the behavior of the mockAuthService.login
      when(mockAuthService.login(email, password))
          .thenAnswer((_) async => userJson);

      await authNotifier.login(email, password);

      // Verify that the correct method was called
      verify(mockAuthService.login(email, password)).called(1);

      // Check that the state was updated correctly
      expect(authNotifier.state.isAuthenticated, true);
      expect(authNotifier.state.user.email, email);
      expect(authNotifier.state.user.isSubscribed, true);
    });

    test('login - failure', () async {
      const email = 'test@example.com';
      const password = 'password';

      when(mockAuthService.login(email, password))
          .thenThrow(Exception('Failed to login'));

      await authNotifier.login(email, password);

      // Verify that the state was updated correctly
      expect(authNotifier.state.isAuthenticated, false);
      expect(authNotifier.state.error, 'Exception: Failed to login');
    });
  });
}
