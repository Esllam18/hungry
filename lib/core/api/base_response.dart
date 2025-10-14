/// Generic model for API responses.
/// Assumes a standard structure: { "success": bool, "data": T, "message": string }.
/// Use like BaseResponse<MyModel>.fromJson(json, (data) => MyModel.fromJson(data));
/// Modify if your API response format is different (e.g., no 'success' field).
class BaseResponse<T> {
  final bool success;
  final T? data;
  final String? message;

  BaseResponse({required this.success, this.data, this.message});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return BaseResponse<T>(
      success: json['success'] ?? true,
      data: json.containsKey('data') ? fromJsonT(json['data']) : null,
      message: json['message'],
    );
  }
}
