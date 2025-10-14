import 'package:dio/dio.dart';
import 'pref_helper.dart';

/// Interceptors for Dio client.
/// Add more interceptors here if needed (e.g., for token refresh).
/// This is modular so you can easily extend (e.g., handle 401 for auth refresh).
class ApiInterceptors {
  static InterceptorsWrapper getAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add token if available. Modify token key or source if needed.
        final token = await PrefHelper.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Add custom response handling if needed (e.g., parse tokens).
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Add custom error handling (e.g., refresh token on 401).
        // Example: if (e.response?.statusCode == 401) { refreshToken(); }
        return handler.next(e);
      },
    );
  }

  /// Logging interceptor for debugging. Controlled by ApiConstants.enableLogging.
  static LogInterceptor getLoggingInterceptor() {
    return LogInterceptor(responseBody: true, requestBody: true);
  }
}
