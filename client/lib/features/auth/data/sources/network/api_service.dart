import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

/// A service for making API requests to our Django server.
class ApiService {
  /// The base URL for the API.
  final String _baseUrl = 'http://127.0.0.1:8000/api';
  final AuthService _authService = AuthService();

  /// Registers a new user.
  Future<Map<String, dynamic>> register(String email, String password, String password2) async {
    final success = await _authService.register(email, password, password2);
    if (success) {
      return {'status': true};
    } else {
      return {'status': false, 'message': 'Registration failed'};
    }
  }

  /// Logs in a user.
  Future<Map<String, dynamic>> login(String email, String password) async {
    final success = await _authService.login(email, password);
    if (success) {
      return {'status': true};
    } else {
      return {'status': false, 'message': 'Login failed'};
    }
  }

  /// Gets the user's information.
  Future<Map<String, dynamic>> getUserInfo() async {
    final accessToken = await _authService.getAccessToken();
    if (accessToken == null) {
      return {'error': 'No valid access token'};
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/user_info/'),
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
      Uri.parse('$_baseUrl/delete_account/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    return response.statusCode == 204;
  }

  /// Whether the user can play the game.
  Future<bool> canPlayGame() async {
    final accessToken = await _authService.getAccessToken();
    if (accessToken == null) {
      return false;
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/can_play/'),
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
      Uri.parse('$_baseUrl/log_play/'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    print('Log game play response status: ${response.statusCode}');
    print('Log game play response body: ${response.body}');

    return response.statusCode == 201;
  }
}
