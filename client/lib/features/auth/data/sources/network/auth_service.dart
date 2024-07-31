// services/auth_service.dart

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/data/sources/local/local_storage_service.dart';

/// The [AuthService] class is responsible for handling authentication requests, managing
/// tokens, and refreshing tokens.
class AuthService {
  final String _baseUrl = 'http://127.0.0.1:8000/api';
  final LocalStorageService _localStorageService = LocalStorageService(
    secureStorage: FlutterSecureStorage(),
  );

  /// Check and validate stored tokens on app startup
  Future<Map<String, dynamic>?> checkStoredTokens() async {
    final accessToken = await _localStorageService.getAccessToken();
    final refreshToken = await _localStorageService.getRefreshToken();

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    // Check if the access token is expired
    if (isTokenExpired(accessToken)) {
      // Try to refresh the access token
      final newAccessToken = await _refreshAccessToken();
      if (newAccessToken == null) {
        return null;
      }
      // Use the new access token
      return await _fetchUserInfo(newAccessToken);
    }

    // Fetch user info using the valid access token
    return await _fetchUserInfo(accessToken);
  }

  Future<Map<String, dynamic>?> _fetchUserInfo(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/account/user_info/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  // Begin region: /account/
  /// Register a new user.
  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String password2,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/account/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'password2': password2,
      }),
    );

    return _handleResponse(response);
  }

  /// Log in a user.
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/account/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final result = _handleResponse(response);

    if (result['access'] != null && result['refresh'] != null) {
      await _localStorageService.saveAuthTokens(
        accessToken: result['access'],
        refreshToken: result['refresh'],
      );
    }

    return result;
  }

  /// Log out the user by deleting the tokens.
  Future<void> logout() async {
    await _localStorageService.deleteAuthTokens();
  }
  // End region: /account/

  // Begin region: /token/
  /// Fetch the access token from the secure storage.
  Future<String?> getAccessToken() async {
    final accessToken = await _localStorageService.getAccessToken();
    if (accessToken != null && isTokenExpired(accessToken)) {
      return await _refreshAccessToken();
    }
    return accessToken;
  }

  /// Whether the token is expired.
  bool isTokenExpired(String token) {
    final payload = _parseJwtPayload(token);
    final expiry = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
    return DateTime.now().isAfter(expiry);
  }

  Future<String?> _refreshAccessToken() async {
    final refreshToken = await _localStorageService.getRefreshToken();

    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    final result = _handleResponse(response);

    if (result['access'] != null) {
      await _localStorageService.saveAuthTokens(
        accessToken: result['access'],
        refreshToken: result['refresh'],
      );
      return result['access'];
    }

    return null;
  }

  /// Delete the user's account.
  Future<void> deleteAccount() async {
    final accessToken = await getAccessToken();

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final response = await http.delete(
      Uri.parse('$_baseUrl/account/delete/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete account');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseBody;
    } else {
      throw Exception(responseBody['error'] ?? 'Unknown error');
    }
  }

  /// Parse the JWT payload.
  Map<String, dynamic> _parseJwtPayload(String token) {
    final parts = token.split('.');
    final payload = utf8.decode(base64.decode(base64.normalize(parts[1])));
    return jsonDecode(payload);
  }
  // End region: /token/
}
