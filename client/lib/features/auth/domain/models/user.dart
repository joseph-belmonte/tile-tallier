// models/user.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// A user model.
@freezed
class User with _$User {
  /// Creates a new [User] instance.
  const factory User({
    @Default(false) bool isAuthenticated,
    @Default('') String email,
    @Default(false) bool isSubscribed,
  }) = _User;

  /// Converts the user to a map.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Default constructor for the user model.
  factory User.initial() => const User(
        isAuthenticated: false,
        email: '',
        isSubscribed: false,
      );
}
