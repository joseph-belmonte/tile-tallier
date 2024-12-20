import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  group('ApiService', () {
    late MockAuthApiService mockApiService;

    setUp(() {
      mockApiService = MockAuthApiService();
    });

    test('getUserInfo returns user data', () async {
      final userJson = {
        'is_authenticated': true,
        'email': 'test@example.com',
        'is_subscribed': true,
      };

      when(mockApiService.getUserInfo()).thenAnswer((_) async => userJson);

      final userInfo = await mockApiService.getUserInfo();

      expect(userInfo['email'], 'test@example.com');
      expect(userInfo['is_subscribed'], true);
    });

    test('getUserInfo returns error', () async {
      when(mockApiService.getUserInfo())
          .thenAnswer((_) async => {'error': 'No valid access token'});

      final userInfo = await mockApiService.getUserInfo();

      expect(userInfo['error'], 'No valid access token');
    });

    test('canPlayGame returns true when user can play', () async {
      when(mockApiService.canPlayGame()).thenAnswer((_) async => true);

      final result = await mockApiService.canPlayGame();

      expect(result, true);
    });

    test('canPlayGame returns false when user cannot play', () async {
      when(mockApiService.canPlayGame()).thenAnswer((_) async => false);

      final result = await mockApiService.canPlayGame();

      expect(result, false);
    });
  });
}
