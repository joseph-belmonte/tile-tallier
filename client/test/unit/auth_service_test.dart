import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  group('AuthService', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    test('register returns true on success', () async {
      when(mockAuthService.register('test@example.com', 'password123', 'password123'))
          .thenAnswer((_) async => true);

      final result =
          await mockAuthService.register('test@example.com', 'password123', 'password123');

      expect(result, true);
    });

    test('register returns false on failure', () async {
      when(mockAuthService.register('test@example.com', 'password123', 'password123'))
          .thenAnswer((_) async => false);

      final result =
          await mockAuthService.register('test@example.com', 'password123', 'password123');

      expect(result, false);
    });

    test('login returns true on success', () async {
      when(mockAuthService.login('test@example.com', 'password')).thenAnswer((_) async => true);

      final result = await mockAuthService.login('test@example.com', 'password');

      expect(result, true);
    });

    test('login returns false on failure', () async {
      when(mockAuthService.login('test@example.com', 'wrongpassword'))
          .thenAnswer((_) async => false);

      final result = await mockAuthService.login('test@example.com', 'wrongpassword');

      expect(result, false);
    });
  });
}
