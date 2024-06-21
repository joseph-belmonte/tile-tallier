import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/// The [AuthService] class is responsible for handling authentication requests, managing
/// tokens, and refreshing tokens.
class AuthService {
  final String _baseUrl = 'http://127.0.0.1:8000/api';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Log in a user.
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: 'access_token', value: data['access']);
      await _storage.write(key: 'refresh_token', value: data['refresh']);
      return true;
    } else {
      print('Login failed: ${response.body}');
      return false;
    }
  }

  /// Register a new user.
  Future<bool> register(String email, String password, String password2) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'password2': password2,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Registration failed: ${response.body}');
      return false;
    }
  }

  /// Fetch the access token from the secure storage.
  Future<String?> getAccessToken() async {
    final accessToken = await _storage.read(key: 'access_token');
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

  /// Fetch a new access token using the refresh token.
  Future<String?> _refreshAccessToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    final response = await http.post(
      Uri.parse('$_baseUrl/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: 'access_token', value: data['access']);
      return data['access'];
    } else {
      await logout();
      return null;
    }
  }

  /// Log out the user by deleting the tokens.
  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }

  /// Parse the JWT payload.
  Map<String, dynamic> _parseJwtPayload(String token) {
    final parts = token.split('.');
    final payload = utf8.decode(base64.decode(base64.normalize(parts[1])));
    return jsonDecode(payload);
  }
}
