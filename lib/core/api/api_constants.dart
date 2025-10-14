/// Central place for API-related constants.
/// Modify these as needed for each project (e.g., change baseUrl to your backend's URL).
class ApiConstants {
  /// Base URL for the API. Change this to your production/staging URL.
  static const String baseUrl = 'https://sonic-zdi0.onrender.com/api';

  /// Timeout durations in milliseconds. Increase if your API is slow.
  static const int connectTimeout = 100000000000;
  static const int receiveTimeout = 100000000000;

  /// Default headers. Add or modify as needed (e.g., add 'User-Agent').
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // Optional: Uncomment if you need no caching for sensitive requests like login.
    // 'Cache-Control': 'no-cache',
  };

  /// Toggle logging for Dio requests (useful for debugging). Set to false in production.
  static const bool enableLogging = true;
}
