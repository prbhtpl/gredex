class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix: $_message";
  }
}

class ValidationException extends AppException {
  ValidationException([String? message]) : super(message, "Validation Error");
}

class AuthException extends AppException {
  AuthException([String? message]) : super(message, 'Auth Error');
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message,/* 'Server Error'*/"");
}

class CommonException extends AppException {
  CommonException([String? message]) : super(message, 'App Exception');
}

class ConnectivityException extends AppException {
  ConnectivityException()
      : super("Something Went wrong", 'Connectivity Error');
}
