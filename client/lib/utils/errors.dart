// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import '../features/shared/presentation/screens/error_page.dart';
import '../features/shared/presentation/screens/error_transition.dart';
import '../main.dart';

class AppException implements Exception {
  final String message;

  AppException(this.message);
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class ServerException extends AppException {
  ServerException(super.message);
}

class AuthException extends AppException {
  AuthException(super.message);
}

class ValidationException extends AppException {
  ValidationException(super.message);
}

/// Handles the error and navigates to the error page with a "scaling" transition.
void handleError(String error, String stackTrace) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    navigatorKey.currentState?.push(
      createErrorRoute(
        ErrorPage(
          errorMessage: error,
          stackTrace: stackTrace,
        ),
      ),
    );
  });
}
