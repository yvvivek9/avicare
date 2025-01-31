import 'package:avicare/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

// https://emojiisland.com/cdn/shop/products/39_large.png?v=1571606117
Widget buildImage({
  required String imagePath,
  double width = 60,
  double height = 60,
  double borderRadius = 10,
  BoxFit fit = BoxFit.cover,
}) {
  return Container(
    width: width.w,
    height: height.h,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.lightPeach,
    ),
    padding: EdgeInsets.all(5.r),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: CachedNetworkImage(
        cacheManager: CacheManager(
          Config(
            'cacheKey',
            stalePeriod: const Duration(days: 14),
          ),
        ),
        imageUrl: imagePath,
        width: (height - 20).h,
        height: (width - 20).w,
        fit: width == height ? BoxFit.contain : fit,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.person,
          size: 50.sp,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
