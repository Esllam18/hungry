import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';

enum LoadingVariant { shimmer, modern, circular, dots }

class LoadingWidget extends StatefulWidget {
  final LoadingVariant variant;
  final bool fullscreen;
  final String? message;
  final Color? color;

  const LoadingWidget({
    super.key,
    this.variant = LoadingVariant.modern,
    this.fullscreen = false,
    this.message,
    this.color,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingWidget = _buildLoadingVariant();

    if (widget.fullscreen) {
      return Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                loadingWidget,
                if (widget.message != null) ...[
                  const SizedBox(height: 24),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      widget.message!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }

    return loadingWidget;
  }

  Widget _buildLoadingVariant() {
    switch (widget.variant) {
      case LoadingVariant.shimmer:
        return _buildShimmerLoader();
      case LoadingVariant.modern:
        return _buildModernLoader();
      case LoadingVariant.circular:
        return _buildCircularLoader();
      case LoadingVariant.dots:
        return _buildDotsLoader();
    }
  }

  Widget _buildModernLoader() {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          // Outer rotating ring
          RotationTransition(
            turns: _rotationAnimation,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.color ?? AppColors.primary,
                  width: 4,
                ),
                gradient: SweepGradient(
                  colors: [
                    (widget.color ?? AppColors.primary).withOpacity(0.1),
                    widget.color ?? AppColors.primary,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // Inner pulsing circle
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (widget.color ?? AppColors.primary).withOpacity(0.2),
                  ),
                  child: Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color ?? AppColors.primary,
                        boxShadow: [
                          BoxShadow(
                            color: (widget.color ?? AppColors.primary)
                                .withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return SizedBox(
      width: 60,
      height: 60,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.color ?? AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildCircularLoader() {
    return SizedBox(
      width: 60,
      height: 60,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                widget.color ?? AppColors.primary,
                (widget.color ?? AppColors.primary).withOpacity(0.3),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDotsLoader() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final delay = index * 0.2;
            final value = (_controller.value - delay).clamp(0.0, 1.0);
            final scale = 1.0 + (0.5 * (1 - (value - 0.5).abs() * 2));

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color ?? AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: (widget.color ?? AppColors.primary).withOpacity(
                          0.5,
                        ),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
