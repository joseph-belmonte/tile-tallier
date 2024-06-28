// providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/sources/network/auth_service.dart';
import '../../domain/models/auth_state.dart';
import '../../domain/models/user.dart';

/// Stores the authentication state and provides methods for authentication.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthService());
});

/// A [StateNotifier] that manages the authentication state.
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  /// Creates a new [AuthNotifier] instance.
  AuthNotifier(this._authService) : super(AuthState.initial()) {
    _initializeAuthState();
  }

  Future<void> _initializeAuthState() async {
    try {
      final userInfo = await _authService.checkStoredTokens();
      if (userInfo != null) {
        final user = User(
          isAuthenticated: true,
          email: userInfo['email'],
          isSubscribed: userInfo['is_subscribed'],
        );
        state = state.copyWith(isAuthenticated: true, user: user);
      }
    } catch (error) {
      state = state.copyWith(error: error.toString());
    }
  }

  /// Registers a new user.
  Future<void> register(String email, String password, String password2) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authService.register(email, password, password2);
      await login(email, password);
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  /// Logs in a user.
  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final result = await _authService.login(email, password);

      if (result.containsKey('user')) {
        final user = User(
          isAuthenticated: true,
          email: result['user']['email'],
          isSubscribed: result['user']['is_subscribed'],
        );

        state =
            state.copyWith(isAuthenticated: true, user: user, isLoading: false);
      } else {
        throw Exception('User data is missing or malformed');
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  /// Logs out the user.
  Future<void> logout() async {
    await _authService.logout();
    state = AuthState.initial();
  }

  /// Deletes the user's account.
  Future<void> deleteAccount() async {
    await _authService.deleteAccount();
    state = AuthState.initial();
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }
}
