import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/sources/network/auth_service.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/user_repository.dart';

/// The [AuthState] class represents the state of the authentication process.
class AuthState {
  /// Whether the user is authenticated.
  final bool isAuthenticated;

  /// An error message.
  final String? error;

  /// The user's information.
  final User? user;

  /// Default constructor for the [AuthState] class.
  AuthState({
    required this.isAuthenticated,
    this.error,
    this.user,
  });
}

/// The [AuthNotifier] class is responsible for handling authentication logic.
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService = AuthService();
  final UserRepository _userRepository = UserRepository();

  /// Default constructor for the [AuthNotifier] class.
  AuthNotifier() : super(AuthState(isAuthenticated: false)) {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final accessToken = await _authService.getAccessToken();
    if (accessToken != null) {
      final user = await _userRepository.getUserInfo();
      if (user != null) {
        state = AuthState(
          isAuthenticated: true,
          user: user,
        );
      } else {
        await _authService.logout();
      }
    }
  }

  /// Registers a new user.
  Future<void> register(String email, String password, String password2) async {
    final result = await _authService.register(email, password, password2);
    if (result) {
      final loginSuccess = await login(email, password);
      if (!loginSuccess) {
        state =
            AuthState(isAuthenticated: false, error: 'Registration successful but login failed');
      }
    } else {
      state = AuthState(isAuthenticated: false, error: 'Registration failed');
    }
  }

  /// Logs in a user.
  Future<bool> login(String email, String password) async {
    final success = await _authService.login(email, password);
    if (success) {
      final user = await _userRepository.getUserInfo();
      if (user != null) {
        state = AuthState(
          isAuthenticated: true,
          user: user,
        );
        return true;
      } else {
        state = AuthState(isAuthenticated: false, error: 'Failed to load user info');
        return false;
      }
    } else {
      state = AuthState(isAuthenticated: false, error: 'Login failed');
      return false;
    }
  }

  /// Logs out the user.
  Future<void> logout() async {
    await _authService.logout();
    state = AuthState(isAuthenticated: false, error: null);
  }

  /// Deletes the user's account.
  Future<void> deleteAccount() async {
    final success = await _userRepository.deleteUserAccount();
    if (success) {
      state = AuthState(isAuthenticated: false, error: null, user: null);
    } else {
      state = AuthState(isAuthenticated: true, error: 'Failed to delete account');
    }
  }
}

/// A provider for the [AuthNotifier].
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
