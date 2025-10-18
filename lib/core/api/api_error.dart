/// Model for API errors.
/// Use this to standardize error responses.
/// If your backend returns a different structure, modify fromJson.
class ApiError {
  final String message;
  final int code;

  ApiError(this.message, this.code);

  /// Factory to parse from JSON (if API returns error as { "message": "", "code": 0 }).
  /// Customize if your error format differs.
  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(json['message'] ?? 'Unknown error', json['code'] ?? 500);
  }

  @override
  String toString() {
    return message;
  }
}
