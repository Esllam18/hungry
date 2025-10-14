import 'package:dio/dio.dart';
import 'api_exception.dart';
import 'dio_client.dart';

/// Main service for API calls.
/// Use this as the entry point for all HTTP requests.
/// Methods are generic and flexible. Returns dynamic (raw data) – parse in your DataSource.
/// Modify to add more methods (e.g., patch) if needed.
class ApiService {
  final DioClient _dioClient = DioClient();

  /// GET request. Supports query params.
  /// Example: await ApiService().get(ApiEndpoints.users, queryParams: {'page': 1});
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dioClient.client.get(
        endpoint,
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e) {
      throw ApiException.handleError(e);
    }
  }

  /// POST request. Supports JSON or form data.
  /// Example: await ApiService().post(ApiEndpoints.login, data: {'email': '...'});
  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    bool isFormData = false,
  }) async {
    try {
      final response = await _dioClient.client.post(
        endpoint,
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } catch (e) {
      throw ApiException.handleError(e);
    }
  }

  /// PUT request.
  /// Similar to POST.
  Future<dynamic> put(
    String endpoint, {
    dynamic data,
    bool isFormData = false,
  }) async {
    try {
      final response = await _dioClient.client.put(
        endpoint,
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } catch (e) {
      throw ApiException.handleError(e);
    }
  }

  /// DELETE request.
  /// Supports query params if needed.
  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dioClient.client.delete(
        endpoint,
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e) {
      throw ApiException.handleError(e);
    }
  }
}
