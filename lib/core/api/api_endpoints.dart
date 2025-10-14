/// Central place for all API endpoints.
/// Add or modify strings here for your project's specific routes.
/// Use these in ApiService calls to avoid hardcoding URLs elsewhere.
/// Example usage: ApiService().get(ApiEndpoints.login);
class ApiEndpoints {
  // Auth-related
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';

  // User-related (add more as needed)
  static const String users = '/users';
  static const String userProfile = '/users/profile';

  // Other examples (customize per project)
  static const String products = '/products';
  static const String orders = '/orders';

  /// Helper to build dynamic endpoints, e.g., ApiEndpoints.withId(ApiEndpoints.users, '123');
  static String withId(String base, String id) => '$base/$id';
}
