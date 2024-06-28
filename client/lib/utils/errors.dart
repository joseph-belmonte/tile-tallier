// ignore_for_file: public_member_api_docs

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
