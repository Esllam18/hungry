// product_repo.dart - Added getToppings, getSideOptions, addToCart.
import 'package:hungry/features/home/data/data_sources/product_remote_data_source.dart';
import 'package:hungry/features/home/data/models/category_model.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/models/topping_model.dart';

class ProductRepository {
  final ProductRemoteDataSource _remoteDataSource = ProductRemoteDataSource();

  /// Get all categories
  Future<List<CategoryModel>> getCategories() async {
    return await _remoteDataSource.getCategories();
  }

  /// Get all products with optional filters
  Future<List<ProductModel>> getProducts({
    int? categoryId,
    String? searchQuery,
  }) async {
    return await _remoteDataSource.getProducts(
      categoryId: categoryId,
      searchQuery: searchQuery,
    );
  }

  /// Get product by ID
  Future<ProductModel> getProductById(int productId) async {
    return await _remoteDataSource.getProductById(productId);
  }

  /// Toggle product favorite status
  Future<bool> toggleFavorite(int productId) async {
    return await _remoteDataSource.toggleFavorite(productId);
  }

  /// Get user's favorite products
  Future<List<ProductModel>> getFavorites() async {
    return await _remoteDataSource.getFavorites();
  }

  /// Get toppings
  Future<List<ToppingModel>> getToppings() async {
    return await _remoteDataSource.getToppings();
  }

  /// Get side options
  Future<List<SideOptionModel>> getSideOptions() async {
    return await _remoteDataSource.getSideOptions();
  }

  /// Add to cart
  Future<void> addToCart(
    int productId,
    List<int> toppingIds,
    List<int> sideOptionIds,
  ) async {
    await _remoteDataSource.addToCart(productId, toppingIds, sideOptionIds);
  }
}
