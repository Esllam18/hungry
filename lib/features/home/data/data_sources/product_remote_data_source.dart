// product_remote_data_source.dart (added addToCart method based on assumed endpoint, fixed any potential issues)
import 'package:hungry/core/api/api_endpoints.dart';
import 'package:hungry/core/api/api_error.dart';
import 'package:hungry/core/api/api_service.dart';
import 'package:hungry/features/home/data/models/category_model.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/models/topping_model.dart';

class ProductRemoteDataSource {
  final ApiService _apiService = ApiService();

  int _parseCode(dynamic code) {
    if (code is int) return code;
    if (code is String) return int.tryParse(code) ?? 500;
    return 500;
  }

  bool _isSuccessful(dynamic code) {
    final intCode = _parseCode(code);
    return intCode >= 200 && intCode < 300;
  }

  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiService.get(ApiEndpoints.categories);

    if (!_isSuccessful(response['code'])) {
      throw ApiError(
        response['message'] ?? 'Failed to load categories',
        _parseCode(response['code']),
      );
    }

    final List<dynamic> data = response['data'] ?? [];
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> getProducts({
    int? categoryId,
    String? searchQuery,
  }) async {
    final queryParams = <String, dynamic>{};
    if (categoryId != null) queryParams['category_id'] = categoryId;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams['name'] = searchQuery;
    }

    final response = await _apiService.get(
      ApiEndpoints.products,
      queryParams: queryParams,
    );

    if (!_isSuccessful(response['code'])) {
      throw ApiError(
        response['message'] ?? 'Failed to load products',
        _parseCode(response['code']),
      );
    }

    final List<dynamic> data = response['data'] ?? [];
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<ProductModel> getProductById(int productId) async {
    final response = await _apiService.get(
      '${ApiEndpoints.products}/$productId',
    );

    if (!_isSuccessful(response['code']) || response['data'] == null) {
      throw ApiError(
        response['message'] ?? 'Failed to load product details',
        _parseCode(response['code']),
      );
    }

    return ProductModel.fromJson(response['data']);
  }

  Future<bool> toggleFavorite(int productId) async {
    final data = {'product_id': productId};
    final response = await _apiService.post(
      ApiEndpoints.toggleFavorite,
      data: data,
    );

    if (!_isSuccessful(response['code'])) {
      throw ApiError(
        response['message'] ?? 'Failed to toggle favorite',
        _parseCode(response['code']),
      );
    }

    return response['data']?['is_favorite'] ?? false;
  }

  Future<List<ProductModel>> getFavorites() async {
    final response = await _apiService.get(ApiEndpoints.favorites);

    if (!_isSuccessful(response['code'])) {
      throw ApiError(
        response['message'] ?? 'Failed to load favorites',
        _parseCode(response['code']),
      );
    }

    final List<dynamic> data = response['data'] ?? [];
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<List<ToppingModel>> getToppings() async {
    final response = await _apiService.get(ApiEndpoints.toppings);

    if (!_isSuccessful(response['code'])) {
      throw ApiError(
        response['message'] ?? 'Failed to load toppings',
        _parseCode(response['code']),
      );
    }

    final List<dynamic> data = response['data'] ?? [];
    return data.map((json) => ToppingModel.fromJson(json)).toList();
  }

  Future<List<SideOptionModel>> getSideOptions() async {
    final response = await _apiService.get(ApiEndpoints.sideOptions);

    if (!_isSuccessful(response['code'])) {
      throw ApiError(
        response['message'] ?? 'Failed to load side options',
        _parseCode(response['code']),
      );
    }

    final List<dynamic> data = response['data'] ?? [];
    return data.map((json) => SideOptionModel.fromJson(json)).toList();
  }

  // Added method for add to cart
  Future<void> addToCart(
    int productId,
    List<int> toppingIds,
    List<int> sideOptionIds,
  ) async {
    final data = {
      'product_id': productId,
      'toppings': toppingIds,
      'side_options': sideOptionIds,
    };
    final response = await _apiService.post(ApiEndpoints.cart, data: data);

    if (!_isSuccessful(response['code'])) {
      throw ApiError(
        response['message'] ?? 'Failed to add to cart',
        _parseCode(response['code']),
      );
    }
  }
}
