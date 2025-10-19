// Add this to your pubspec.yaml:
// dependencies:
//   cached_network_image: ^3.3.0

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hungry/core/consts/app_colors.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({super.key, required this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    // Default placeholder image
    const String defaultImage =
        'https://cdn3.iconfinder.com/data/icons/gradient-general-pack/512/user-01-512.png';

    // Convert http to https if needed
    String? processedUrl = imageUrl;
    if (processedUrl != null && processedUrl.startsWith('http://')) {
      processedUrl = processedUrl.replaceFirst('http://', 'https://');
    }

    // Check if imageUrl is valid
    final bool isValidUrl =
        processedUrl != null &&
        processedUrl.isNotEmpty &&
        (processedUrl.startsWith('http://') ||
            processedUrl.startsWith('https://'));

    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 120.55.w,
          height: 120.94.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: isValidUrl ? processedUrl : defaultImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
              errorWidget: (context, url, error) {
                print('Error loading image from $url: $error');
                // Try default image
                if (url != defaultImage) {
                  return CachedNetworkImage(
                    imageUrl: defaultImage,
                    fit: BoxFit.cover,
                    errorWidget: (context, url2, error2) {
                      return _buildFallbackIcon();
                    },
                  );
                }
                return _buildFallbackIcon();
              },
              fadeInDuration: const Duration(milliseconds: 300),
              fadeOutDuration: const Duration(milliseconds: 100),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Container(
      color: Colors.grey[100],
      child: Icon(
        Icons.person,
        size: 60.sp,
        color: AppColors.primary.withOpacity(0.5),
      ),
    );
  }
}
