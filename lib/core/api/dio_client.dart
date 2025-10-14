import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'api_interceptors.dart';

/// Singleton Dio client.
/// Initializes Dio with base config and interceptors.
/// Modify BaseOptions if you need custom settings (e.g., followRedirects).
class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
      receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
      headers: ApiConstants.headers,
    ),
  );

  DioClient() {
    // Add interceptors. Order matters: auth first, then logging.
    _dio.interceptors.add(ApiInterceptors.getAuthInterceptor());
    if (ApiConstants.enableLogging) {
      _dio.interceptors.add(ApiInterceptors.getLoggingInterceptor());
    }
  }

  Dio get client => _dio;
}
