class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => message;
}

class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection', super.code]);
}

class ServerException extends AppException {
  const ServerException([super.message = 'An unexpected server error occurred', super.code]);
}
