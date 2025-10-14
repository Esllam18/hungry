import 'package:shared_preferences/shared_preferences.dart';

/// Helper for SharedPreferences.
/// Stores token and other common values.
/// Modify keys or add methods for project-specific prefs (e.g., userId).
/// Note: For secure storage (e.g., tokens in production), consider flutter_secure_storage instead.
class PrefHelper {
  static const String _tokenKey =
      'auth_token'; // Changed from 'abc123token' for clarity.

  /// Save token. Call after login.
  static Future<void> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    } catch (e) {
      // Handle error (e.g., log it). Modify as needed.
    }
  }

  /// Get token. Returns null if not set.
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      return null;
    }
  }

  /// Clear token. Call on logout.
  static Future<void> clearToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
    } catch (e) {
      // Handle error.
    }
  }

  // Additional utility (example: for user ID)
  static const String _userIdKey = 'user_id';
  static Future<void> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, id);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }
}
