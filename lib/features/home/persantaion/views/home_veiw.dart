import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_snackbar.dart';
import 'package:hungry/core/widgets/loading_widget.dart';
import 'package:hungry/features/home/persantaion/cubit/product_cubit.dart';
import 'package:hungry/features/home/persantaion/cubit/product_state.dart';
import 'package:hungry/features/home/persantaion/widgets/home_content.dart';
import 'package:hungry/features/home/persantaion/widgets/home_error.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductCubit>().initialize();
    });
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (value.isEmpty) {
      context.read<ProductCubit>().searchProducts('');
      return;
    }
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted && _searchController.text == value) {
        context.read<ProductCubit>().searchProducts(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
              if (state is ProductError) {
                CustomSnackBar.show(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              } else if (state is FavoriteToggleSuccess) {
                CustomSnackBar.show(
                  context,
                  message: state.isFavorite
                      ? 'Added to favorites ❤️'
                      : 'Removed from favorites',
                  type: state.isFavorite
                      ? SnackBarType.success
                      : SnackBarType.info,
                );
              }
            },
            builder: (context, state) {
              if (state is ProductLoading || state is ProductInitial) {
                return const Center(
                  child: LoadingWidget(variant: LoadingVariant.modern),
                );
              }

              if (state is ProductLoaded) {
                return HomeContent(
                  products: state.products,
                  categories: state.categories,
                  selectedCategoryId: state.selectedCategoryId,
                  searchController: _searchController,
                  scrollController: _scrollController,
                  fadeAnimation: _fadeAnimation,
                  onSearchChanged: _onSearchChanged,
                  responsive: responsive,
                );
              }

              return HomeError(responsive: responsive);
            },
          ),
        ),
      ),
    );
  }
}
