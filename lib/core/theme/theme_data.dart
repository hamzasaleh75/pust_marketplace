import 'package:flutter/material.dart';
import 'package:quick_store/core/theme/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  scaffoldBackgroundColor: AppColors.lightBackground,

  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.white,

    secondary: AppColors.secondary,
    onSecondary: AppColors.white,

    tertiary: AppColors.tertiary,

    surface: AppColors.lightSurface,
    onSurface: AppColors.lightTextPrimary,

    inverseSurface: AppColors.black,

    error: AppColors.error,
    onError: AppColors.white,

    secondaryContainer: AppColors.grey100,
    onSecondaryContainer: AppColors.lightTextPrimary,

    
  ),

  cardTheme: const CardThemeData(
    color: AppColors.lightCard,
    elevation: 5,
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: AppColors.lightTextPrimary,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),

    titleMedium: TextStyle(
      color: AppColors.lightTextPrimary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),

    bodySmall: TextStyle(
      color: AppColors.lightTextSecondary,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),

    displayMedium: TextStyle(
      color: AppColors.lightTextPrimary,
      fontSize: 22,
    ),
  ),
);
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  scaffoldBackgroundColor: AppColors.darkBackground,

  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: AppColors.white,

    secondary: AppColors.secondary,
    onSecondary: AppColors.white,

    tertiary: AppColors.tertiary,

    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,

    inverseSurface: AppColors.white,

    error: AppColors.error,
    onError: AppColors.white,

    secondaryContainer: AppColors.grey800,
    onSecondaryContainer: AppColors.darkTextPrimary,
  ),

  cardTheme: const CardThemeData(
    color: AppColors.darkCard,
    elevation: 5,
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),

    titleMedium: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),

    bodySmall: TextStyle(
      color: AppColors.darkTextSecondary,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),

    displayMedium: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 22,
    ),
  ),
);
