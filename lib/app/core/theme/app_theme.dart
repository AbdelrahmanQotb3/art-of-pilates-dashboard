import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
    ),
    scaffoldBackgroundColor: AppColors.secondaryColor,

    // appBarTheme
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.blackColor),
      leadingWidth: 20.w,
      titleTextStyle: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
        foregroundColor: WidgetStateProperty.all(AppColors.whiteColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.h),
        ),
      ),
    ),

    // textStyle
    textTheme: TextTheme(
      labelMedium: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.grayColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
    ),
  );
}
