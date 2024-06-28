// models/auth_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

/// The [AuthState] class is responsible for handling the state of the authentication
/// throughout the application.
@freezed
class AuthState with _$AuthState {
  /// Create an instance of the [AuthState] class
  const factory AuthState({
    @Default(false) bool isAuthenticated,
    @Default(false) bool isLoading,
    @Default(User()) User user,
    String? error,
  }) = _AuthState;

  /// Create an initial instance of the [AuthState] class
  factory AuthState.initial() => const AuthState();

  /// Converts the authentication state to a map.
  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
