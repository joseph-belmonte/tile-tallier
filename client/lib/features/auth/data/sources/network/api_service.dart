//  Has separate methods for each specific API operation
// e.g.: (register, login, refreshToken).
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../shared/data/urls.dart';
import 'auth_service.dart';

/// A service for making API requests to our Django server.
class AuthApiService {
  /// The base URL for the API.
  final String _baseUrl = '$baseUrl/$api_version';
  final AuthService _authService = AuthService();

  // Begin region: /account/
  /// Registers a new user.
  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String password2,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/account/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'password2': password2,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to register: $error');
    }
  }

  /// Logs in a user.
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/account/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  /// Gets the user's information.
  Future<Map<String, dynamic>> getUserInfo() async {
    final accessToken = await _authService.getAccessToken();
    if (accessToken == null) {
      return {'error': 'No valid access token'};
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/account/user_info/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'error': 'Failed to get user info'};
    }
  }

  /// Deletes the user's account.
  Future<bool> deleteAccount() async {
    final accessToken = await _authService.getAccessToken();
    if (accessToken == null) {
      return false;
    }

    final response = await http.delete(
      Uri.parse('$_baseUrl/account/delete_account/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    return response.statusCode == 204;
  }
  // End region: /account/

  // Begin region: /game/
  /// Whether the user can play the game.
  Future<bool> canPlayGame() async {
    final accessToken = await _authService.getAccessToken();
    if (accessToken == null) {
      return false;
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/game/can_play/'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    print('Can play game response status: ${response.statusCode}');
    print('Can play game response body: ${response.body}');

    return response.statusCode == 200;
  }

  /// Logs the user's game play.
  Future<bool> logGamePlay() async {
    final accessToken = await _authService.getAccessToken();
    if (accessToken == null) {
      return false;
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/game/log_play/'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    print('Log game play response status: ${response.statusCode}');
    print('Log game play response body: ${response.body}');

    return response.statusCode == 201;
  }
  // End region: /game/
}
