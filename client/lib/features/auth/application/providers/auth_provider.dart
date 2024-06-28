// providers/auth_provider.dart
// TODO: once login working, keep user logged in across app restarts
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/logger.dart';
import '../../data/sources/network/auth_service.dart';
import '../../domain/models/auth_state.dart';
import '../../domain/models/user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthService());
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState.initial());

  Future<void> register(String email, String password, String password2) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authService.register(email, password, password2);
      await login(email, password);
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final result = await _authService.login(email, password);

      logger.d('Login result: $result');

      if (result.containsKey('user')) {
        final user = User(
          isAuthenticated: true,
          email: result['user']['email'],
          isSubscribed: result['user']['is_subscribed'],
        );

        logger.d('User: ${user.toString()}');
        state =
            state.copyWith(isAuthenticated: true, user: user, isLoading: false);
      } else {
        throw Exception('User data is missing or malformed');
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = AuthState.initial();
  }

  Future<void> deleteAccount() async {
    await _authService.deleteAccount();
    state = AuthState.initial();
  }

  // clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
