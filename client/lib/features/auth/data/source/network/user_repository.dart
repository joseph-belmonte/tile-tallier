import '../../../domain/user.dart';
import 'api_service.dart';

/// A repository for handling user data.
class UserRepository {
  final ApiService _apiService = ApiService();

  /// Fetches the user's information.
  Future<User?> getUserInfo() async {
    final response = await _apiService.getUserInfo();
    if (response.containsKey('error')) {
      return null;
    }
    return User.fromJson(response);
  }

  /// Deletes the user's account.
  Future<bool> deleteUserAccount() async {
    return await _apiService.deleteAccount();
  }
}
