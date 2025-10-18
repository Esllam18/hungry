import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/home/data/models/category_model.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/models/topping_model.dart';
import 'package:hungry/features/home/data/repositories/product_repo.dart';
import 'package:hungry/features/home/persantaion/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository = ProductRepository();

  ProductCubit() : super(ProductInitial());

  List<ProductModel> _allProducts = [];
  List<CategoryModel> _categories = [];
  List<ToppingModel> _toppings = [];
  List<SideOptionModel> _sideOptions = [];
  int? _selectedCategoryId;
  String? _searchQuery;

  /// Initialize - Load categories, products, toppings, and side options
  Future<void> initialize() async {
    emit(ProductLoading());
    try {
      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getProducts(),
        _repository.getToppings(),
        _repository.getSideOptions(),
      ]);

      _categories = results[0] as List<CategoryModel>;
      _allProducts = results[1] as List<ProductModel>;
      _toppings = results[2] as List<ToppingModel>;
      _sideOptions = results[3] as List<SideOptionModel>;

      emit(
        ProductLoaded(
          products: _allProducts,
          categories: _categories,
          toppings: _toppings,
          sideOptions: _sideOptions,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  /// Load products with filters
  Future<void> loadProducts({int? categoryId, String? searchQuery}) async {
    try {
      final currentState = state;
      if (currentState is ProductLoaded) {
        _categories = currentState.categories;
        _toppings = currentState.toppings;
        _sideOptions = currentState.sideOptions;
      }

      emit(ProductLoading());

      _selectedCategoryId = categoryId;
      _searchQuery = searchQuery;

      final products = await _repository.getProducts(
        categoryId: categoryId,
        searchQuery: searchQuery,
      );

      _allProducts = products;

      emit(
        ProductLoaded(
          products: products,
          categories: _categories,
          toppings: _toppings,
          sideOptions: _sideOptions,
          selectedCategoryId: categoryId,
          searchQuery: searchQuery,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  /// Filter by category
  Future<void> filterByCategory(int? categoryId) async {
    await loadProducts(categoryId: categoryId, searchQuery: _searchQuery);
  }

  /// Search products
  Future<void> searchProducts(String query) async {
    await loadProducts(
      categoryId: _selectedCategoryId,
      searchQuery: query.isEmpty ? null : query,
    );
  }

  /// Clear all filters
  Future<void> clearFilters() async {
    await loadProducts();
  }

  /// Get product details by ID
  Future<void> getProductDetails(int productId) async {
    emit(ProductLoading());
    try {
      final results = await Future.wait([
        _repository.getProductById(productId),
        _repository.getToppings(),
        _repository.getSideOptions(),
      ]);

      final product = results[0] as ProductModel;
      _toppings = results[1] as List<ToppingModel>;
      _sideOptions = results[2] as List<SideOptionModel>;

      emit(
        ProductDetailsLoaded(
          product: product,
          toppings: _toppings,
          sideOptions: _sideOptions,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(int productId) async {
    try {
      final isFavorite = await _repository.toggleFavorite(productId);

      _allProducts = _allProducts.map((product) {
        if (product.id == productId) {
          return product.copyWith(isFavorite: isFavorite);
        }
        return product;
      }).toList();

      final currentState = state;
      if (currentState is ProductLoaded) {
        emit(
          currentState.copyWith(
            products: _allProducts,
            toppings: _toppings,
            sideOptions: _sideOptions,
          ),
        );
      } else if (currentState is ProductDetailsLoaded) {
        emit(
          ProductDetailsLoaded(
            product: currentState.product.copyWith(isFavorite: isFavorite),
            toppings: _toppings,
            sideOptions: _sideOptions,
          ),
        );
      }

      emit(FavoriteToggleSuccess(productId, isFavorite));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  /// Get favorites
  Future<void> loadFavorites() async {
    emit(ProductLoading());
    try {
      final favorites = await _repository.getFavorites();
      _allProducts = favorites;
      emit(
        ProductLoaded(
          products: favorites,
          categories: _categories,
          toppings: _toppings,
          sideOptions: _sideOptions,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  /// Refresh products
  Future<void> refresh() async {
    await loadProducts(
      categoryId: _selectedCategoryId,
      searchQuery: _searchQuery,
    );
  }

  /// Add to cart
  Future<void> addToCart(
    int productId,
    List<int> toppingIds,
    List<int> sideOptionIds,
  ) async {
    emit(ProductLoading());
    try {
      await _repository.addToCart(productId, toppingIds, sideOptionIds);
      emit(
        ProductDetailsLoaded(
          product: _allProducts.firstWhere(
            (p) => p.id == productId,
            orElse: () => (state as ProductDetailsLoaded).product,
          ),
          toppings: _toppings,
          sideOptions: _sideOptions,
        ),
      );
      // Optionally trigger a snackbar in the UI
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  /// Get toppings
  Future<void> getToppings() async {
    try {
      final toppings = await _repository.getToppings();
      _toppings = toppings;
      final currentState = state;
      if (currentState is ProductLoaded) {
        emit(currentState.copyWith(toppings: toppings));
      } else if (currentState is ProductDetailsLoaded) {
        emit(
          ProductDetailsLoaded(
            product: currentState.product,
            toppings: toppings,
            sideOptions: currentState.sideOptions,
          ),
        );
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  /// Get side options
  Future<void> getSideOptions() async {
    try {
      final sideOptions = await _repository.getSideOptions();
      _sideOptions = sideOptions;
      final currentState = state;
      if (currentState is ProductLoaded) {
        emit(currentState.copyWith(sideOptions: sideOptions));
      } else if (currentState is ProductDetailsLoaded) {
        emit(
          ProductDetailsLoaded(
            product: currentState.product,
            toppings: currentState.toppings,
            sideOptions: sideOptions,
          ),
        );
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
