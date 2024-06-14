/// A user model.
class User {
  /// the id of the user.
  final bool? isAuthenticated;

  /// the email of the user.
  final String? email;

  /// Whether the user is subscribed.
  final bool? isSubscribed;

  /// The expiry date of the user's subscription.
  final DateTime? subscriptionExpiry;

  /// A list of the user's purchases.
  final List<String?> purchases;

  /// Default constructor for the user model.
  User({
    required this.isAuthenticated,
    required this.email,
    required this.isSubscribed,
    required this.purchases,
    this.subscriptionExpiry,
  });

  /// Converts a JSON object to a user model.
  factory User.fromJson(Map<String, dynamic> json) => User(
        isAuthenticated: json['is_authenticated'],
        email: json['email'],
        isSubscribed: json['is_subscribed'],
        purchases: List<String>.from(json['purchases']),
        subscriptionExpiry: json['subscription_expiry'] != null
            ? DateTime.parse(json['subscription_expiry'])
            : null,
      );
}
