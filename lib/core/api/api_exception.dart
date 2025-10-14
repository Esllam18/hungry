import 'package:dio/dio.dart';
import 'api_error.dart';

/// Custom exception for API errors.
/// Handles Dio errors and maps them to ApiError.
/// Modify the switch cases if you need custom handling for specific error types or codes.
class ApiException implements Exception {
  static ApiError handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return ApiError('Request was cancelled', 499);
        case DioExceptionType.connectionTimeout:
          return ApiError('Connection timeout', 408);
        case DioExceptionType.receiveTimeout:
          return ApiError('Receive timeout', 408);
        case DioExceptionType.sendTimeout:
          return ApiError('Send timeout', 408);
        case DioExceptionType.badResponse:
          if (error.response != null) {
            final data = error.response?.data;

            // Handle validation errors (422 status code with errors object)
            if (error.response?.statusCode == 422 &&
                data is Map<String, dynamic>) {
              if (data.containsKey('errors')) {
                // Extract first error message from errors object
                final errors = data['errors'] as Map<String, dynamic>;
                if (errors.isNotEmpty) {
                  final firstError = errors.values.first;
                  if (firstError is List && firstError.isNotEmpty) {
                    return ApiError(firstError[0].toString(), 422);
                  }
                }
              }
              // Fallback to message if no errors field
              if (data.containsKey('message')) {
                return ApiError(data['message'].toString(), 422);
              }
            }

            // Handle standard error response with message field
            if (data is Map<String, dynamic> && data.containsKey('message')) {
              return ApiError.fromJson(data);
            }

            return ApiError(
              'Received invalid status code: ${error.response?.statusCode}',
              error.response?.statusCode ?? 500,
            );
          } else {
            return ApiError(
              'Received invalid status code with no response',
              500,
            );
          }
        case DioExceptionType.unknown:
          return ApiError('Network error occurred', 503);
        default:
          return ApiError('An unexpected error occurred', 500);
      }
    }
    // For non-Dio errors
    return ApiError('An error occurred: $error', 500);
  }
}
