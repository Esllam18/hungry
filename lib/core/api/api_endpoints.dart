/// Central place for all API endpoints.
/// Add or modify strings here for your project's specific routes.
/// Use these in ApiService calls to avoid hardcoding URLs elsewhere.
class ApiEndpoints {
  // Auth-related
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String profile = '/profile';
  static const String updateProfile = '/update-profile';

  // User-related
  static const String users = '/users';
  static const String userProfile = '/users/profile';

  // Category-related
  static const String categories = '/categories';

  // Product-related
  static const String products = '/products';

  // Favorite-related
  static const String toggleFavorite = '/toggle-favorite';
  static const String favorites = '/favorites';

  // Product Options
  static const String toppings = '/toppings';
  static const String sideOptions = '/side-options';

  // Order-related
  static const String orders = '/orders';

  // Cart-related
  static const String cart = '/cart';
  static const String cartAdd = '/cart/add';
  static String cartRemove(int itemId) => '/cart/remove/$itemId';

  /// Helper to build dynamic endpoints
  static String withId(String base, String id) => '$base/$id';
}
