import 'package:hungry/core/api/api_endpoints.dart';
import 'package:hungry/core/api/api_error.dart';
import 'package:hungry/core/api/api_service.dart';
import 'package:hungry/core/api/pref_helper.dart';
import 'package:hungry/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final ApiService _apiService = ApiService();

  /// Helper method to parse code as int (handles both String and int)
  int _parseCode(dynamic code) {
    if (code is int) return code;
    if (code is String) return int.tryParse(code) ?? 500;
    return 500;
  }

  /// Helper method to check if response is successful
  bool _isSuccessful(dynamic code) {
    final intCode = _parseCode(code);
    return intCode >= 200 && intCode < 300;
  }

  Future<UserModel> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    final response = await _apiService.post(ApiEndpoints.login, data: data);

    // Validate response structure
    if (!_isSuccessful(response['code']) || response['data'] == null) {
      throw ApiError(
        response['message'] ?? 'Login failed',
        _parseCode(response['code']),
      );
    }

    // Extract token from response['data']['token']
    final token = response['data']['token'];
    if (token == null || token.toString().isEmpty) {
      throw ApiError('Token not found in response', 401);
    }

    // Save token
    await PrefHelper.saveToken(token.toString());

    // Parse user model using only the 'data' part of the response
    final user = UserModel.fromJson({'data': response['data']});

    return user;
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    String? image,
  }) async {
    final data = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      if (image != null) 'image': image, // Optional field
    };

    final response = await _apiService.post(ApiEndpoints.register, data: data);

    // Validate response structure
    if (!_isSuccessful(response['code']) || response['data'] == null) {
      throw ApiError(
        response['message'] ?? 'Registration failed',
        _parseCode(response['code']),
      );
    }

    // Extract token from response['data']['token']
    final token = response['data']['token'];
    if (token == null || token.toString().isEmpty) {
      throw ApiError('Token not found in response', 401);
    }

    // Save token
    await PrefHelper.saveToken(token.toString());

    // Parse user model using only the 'data' part of the response
    final user = UserModel.fromJson({'data': response['data']});

    return user;
  }

  Future<void> logout() async {
    // No data needed for logout, just the token in the header via interceptor
    final response = await _apiService.post(ApiEndpoints.logout);

    // Validate response structure
    if (!_isSuccessful(response['code'])) {
      throw ApiError(
        response['message'] ?? 'Logout failed',
        _parseCode(response['code']),
      );
    }

    // Clear token on successful logout
    await PrefHelper.clearToken();
  }

  // get current user details
  Future<UserModel> getCurrentUser() async {
    final response = await _apiService.get(ApiEndpoints.profile);

    // Validate response structure
    if (!_isSuccessful(response['code']) || response['data'] == null) {
      throw ApiError(
        response['message'] ?? 'Failed to fetch user details',
        _parseCode(response['code']),
      );
    }

    // Parse user model using only the 'data' part of the response
    final user = UserModel.fromJson({'data': response['data']});

    return user;
  }

  // update user details
  Future<UserModel> updateUser({
    String? name,
    String? email,
    String? phone,
    String? image,
    String? address,
    String? visa,
  }) async {
    final data = {
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (image != null) 'image': image,
      if (address != null) 'address': address,
      if (visa != null) 'Visa': visa,
    };

    final response = await _apiService.post(
      ApiEndpoints.updateProfile,
      data: data,
    );

    // Validate response structure
    if (!_isSuccessful(response['code']) || response['data'] == null) {
      throw ApiError(
        response['message'] ?? 'Failed to update user details',
        _parseCode(response['code']),
      );
    }

    // Parse user model using only the 'data' part of the response
    final user = UserModel.fromJson({'data': response['data']});

    return user;
  }
}
