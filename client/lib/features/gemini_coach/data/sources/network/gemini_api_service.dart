import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../auth/data/sources/network/auth_service.dart';
import '../../../../core/domain/models/game.dart';
import '../../../../shared/data/urls.dart';

/// Sends a request to the backend to fetch advice.
/// The request body contains a player's plays.
class GeminiApiService {
  final AuthService _authService = AuthService();

  /// Accepts a playerId and sends a request for personalized advice.
  Future<Map<String, dynamic>> fetchAdvice(
    String playerId,
    List<Game> games,
  ) async {
    // Verify the user is authenticated
    final accessToken = await _authService.getAccessToken();
    if (accessToken == null) {
      return {
        'statusCode': HttpStatus.unauthorized,
      };
    }

    // Check the last time advice was fetched, enforce some sort of time limit for rate limiting

    // Get the URL, we will make a request to my backend
    const apiBaseUrl = '$baseUrl/api';
    final url = Uri.parse('$apiBaseUrl/gemini/advice/');

    // Get the header
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    // Get the body
    // The body should be equal to the serialized game history for the given player
    // Use the games and playerId to create the body
    final body = json.encode({
      'player_id': playerId,
      'game_data': games.map((game) => game.toJson()).toList(),
    });

    // Send the request
    final request = await http.post(
      url,
      headers: header,
      body: body,
    );

    // Return the response
    final response = request;

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch advice: ${response.body}');
    }
  }
}
