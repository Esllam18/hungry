import 'package:hungry/features/home/data/models/category_model.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/models/topping_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final List<ToppingModel> toppings;
  final List<SideOptionModel> sideOptions;
  final int? selectedCategoryId;
  final String? searchQuery;

  ProductLoaded({
    required this.products,
    required this.categories,
    required this.toppings,
    required this.sideOptions,
    this.selectedCategoryId,
    this.searchQuery,
  });

  ProductLoaded copyWith({
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    List<ToppingModel>? toppings,
    List<SideOptionModel>? sideOptions,
    int? selectedCategoryId,
    String? searchQuery,
    bool clearCategory = false,
    bool clearSearch = false,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      toppings: toppings ?? this.toppings,
      sideOptions: sideOptions ?? this.sideOptions,
      selectedCategoryId: clearCategory
          ? null
          : (selectedCategoryId ?? this.selectedCategoryId),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
    );
  }
}

class ProductDetailsLoaded extends ProductState {
  final ProductModel product;
  final List<ToppingModel> toppings; // Added
  final List<SideOptionModel> sideOptions; // Added

  ProductDetailsLoaded({
    required this.product,
    this.toppings = const [], // Default to empty list
    this.sideOptions = const [], // Default to empty list
  });
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class FavoriteToggleSuccess extends ProductState {
  final int productId;
  final bool isFavorite;

  FavoriteToggleSuccess(this.productId, this.isFavorite);
}
