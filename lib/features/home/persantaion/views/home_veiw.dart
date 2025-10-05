import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/core/widgets/custom_text_field.dart';
import 'package:hungry/features/home/persantaion/widgets/categories_filtertion.dart';
import 'package:hungry/features/home/persantaion/widgets/home_header.dart';
import 'package:hungry/features/home/persantaion/widgets/food_card.dart';

class HomeVeiw extends StatefulWidget {
  const HomeVeiw({super.key});

  @override
  State<HomeVeiw> createState() => _HomeVeiwState();
}

class _HomeVeiwState extends State<HomeVeiw> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  // ignore: unused_field
  late Animation<Offset> _slideAnimation;

  // Pagination variables
  // ignore: unused_field
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  bool _isLoadingMore = false;
  List<int> _items = List.generate(10, (index) => index);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _currentPage++;
        final newItems = List.generate(
          _itemsPerPage,
          (index) => _items.length + index,
        );
        _items.addAll(newItems);
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _currentPage = 1;
        _items = List.generate(10, (index) => index);
      });
    }
  }

  Widget _buildAnimatedSection({required int index, required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 150)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: FadeTransition(
            opacity: _fadeAnimation,
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppColors.primary,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Header Section with animation
                  SliverToBoxAdapter(
                    child: _buildAnimatedSection(
                      index: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.setWidth(20),
                          vertical: responsive.setHeight(10),
                        ),
                        child: const HomeHeader(),
                      ),
                    ),
                  ),

                  // Search Field with animation
                  SliverToBoxAdapter(
                    child: _buildAnimatedSection(
                      index: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.setWidth(20),
                        ),
                        child: Column(
                          children: [
                            Gap(responsive.setHeight(20)),
                            CustomTextField(
                              controller: _searchController,
                              prefix: Icon(
                                CupertinoIcons.search,
                                color: AppColors.black,
                                size: responsive.setWidth(20),
                              ),
                              hint: CustomText(
                                txt: 'Search...',
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff3C2F2F),
                                fontSize: responsive.setFont(18),
                              ),
                              suffix: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _searchController.clear();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        size: responsive.setWidth(18),
                                      ),
                                    )
                                  : null,
                            ),
                            Gap(responsive.setHeight(10)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Categories Filter with animation
                  SliverToBoxAdapter(
                    child: _buildAnimatedSection(
                      index: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.setWidth(20),
                          vertical: responsive.setHeight(10),
                        ),
                        child: const FilterationShipsChoise(),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: Gap(responsive.setHeight(15))),

                  // Grid Items with staggered animation
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.setWidth(20),
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: responsive.isMobile
                            ? 2
                            : (responsive.isTablet ? 3 : 4),
                        mainAxisSpacing: responsive.setHeight(12),
                        crossAxisSpacing: responsive.setWidth(12),
                        childAspectRatio: 0.7,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 600 + (index * 50)),
                          curve: Curves.easeOutBack,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Opacity(
                                opacity: value.clamp(0.0, 1.0),
                                child: child,
                              ),
                            );
                          },
                          child: FoodCard(
                            index: _items[index],
                            responsive: responsive,
                          ),
                        );
                      }, childCount: _items.length),
                    ),
                  ),

                  // Loading indicator with animation
                  if (_isLoadingMore)
                    SliverToBoxAdapter(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) {
                          return Opacity(opacity: value, child: child);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: responsive.setHeight(20),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),

                  SliverToBoxAdapter(child: Gap(responsive.setHeight(20))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
