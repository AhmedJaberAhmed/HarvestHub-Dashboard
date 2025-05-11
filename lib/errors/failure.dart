// Base class
abstract class Failure {
  final String message;
  Failure(this.message);
}

// Server/API-related failure
class ServerFailure extends Failure {
  ServerFailure([super.message = 'Server error occurred']);
}

// No internet / connection issues
class ConnectionFailure extends Failure {
  ConnectionFailure([super.message = 'No internet connection']);
}

// Cache/local storage issues
class CacheFailure extends Failure {
  CacheFailure([super.message = 'Cache failure']);
}

// Database-related failure
class DatabaseFailure extends Failure {
  DatabaseFailure([super.message = 'Database failure']);
}

// Unauthorized access
class UnauthorizedFailure extends Failure {
  UnauthorizedFailure([super.message = 'Unauthorized access']);
}

// Invalid input or form validation issues
class ValidationFailure extends Failure {
  ValidationFailure([super.message = 'Invalid input']);
}

// Timeout
class TimeoutFailure extends Failure {
  TimeoutFailure([super.message = 'Request timed out']);
}

// Unknown or generic failure
class UnknownFailure extends Failure {
  UnknownFailure([super.message = 'An unknown error occurred']);
}
