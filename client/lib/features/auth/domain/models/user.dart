/// A user model.
class User {
  /// the id of the user.
  final bool? isAuthenticated;

  /// the email of the user.
  final String? email;

  /// Whether the user is subscribed.
  final bool? isSubscribed;

  /// Default constructor for the user model.
  User({
    required this.isAuthenticated,
    required this.email,
    required this.isSubscribed,
  });

  /// Converts a JSON object to a user model.
  factory User.fromJson(Map<String, dynamic> json) => User(
        isAuthenticated: json['is_authenticated'],
        email: json['email'],
        isSubscribed: json['is_subscribed'],
      );
}
