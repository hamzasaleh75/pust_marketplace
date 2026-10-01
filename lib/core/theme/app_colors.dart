import 'package:flutter/material.dart';

abstract class AppColors {
  // =========================
  // 1. Primary Colors
  // =========================


  static const primary = Color(0xFF4CAF50);
  static const primaryLight = Color(0xFF81C784);
  static const primaryDark = Color(0xFF388E3C);

  static const secondary = Color(0xFF2196F3);
  static const secondaryLight = Color(0xFF64B5F6);
  static const secondaryDark = Color(0xFF1976D2);

  // =========================
  // 2. Status Colors
  // =========================

  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFE53935);
  static const warning = Color(0xFFFFA000);
  static const info = Color(0xFF2196F3);

  // =========================
  // 3. Light Theme Colors
  // =========================

  static const lightBackground = Color(0xFFF8F9FA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFFFFFFF);

  static const lightTextPrimary = Color(0xFF212121);
  static const lightTextSecondary = Color(0xFF757575);
  static const lightTextHint = Color(0xFF9E9E9E);

  static const lightDivider = Color(0xFFE0E0E0);
  static const lightBorder = Color(0xFFDDDDDD);

  // =========================
  // 4. Dark Theme Colors
  // =========================

  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkCard = Color(0xFF242424);

  static const darkTextPrimary = Color(0xFFFFFFFF);
  static const darkTextSecondary = Color(0xFFBDBDBD);
  static const darkTextHint = Color(0xFF757575);

  static const darkDivider = Color(0xFF333333);
  static const darkBorder = Color(0xFF424242);

  // =========================
  // 5. Common Colors
  // =========================

  // Basic
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Colors.transparent;

  // Red
  static const red = Color(0xFFF44336);
  static const redDark = Color(0xFFD32F2F);

  // Green
  static const green = Color(0xFF4CAF50);
  static const greenDark = Color(0xFF388E3C);

  // Amber / Yellow
  static const amber = Color(0xFFFFC107);
  static const amberDark = Color(0xFFFFA000);

  // Blue
  static const blue = Color(0xFF2196F3);
  static const blueDark = Color(0xFF1976D2);

  // Orange
  static const orange = Color(0xFFFF9800);
  static const orangeDark = Color(0xFFF57C00);

  // Purple
  static const purple = Color(0xFF9C27B0);
  static const purpleDark = Color(0xFF7B1FA2);

  // Pink
  static const pink = Color(0xFFE91E63);
  static const pinkDark = Color(0xFFC2185B);

  // Teal
  static const teal = Color(0xFF009688);
  static const tealDark = Color(0xFF00796B);

  // =========================
  // 6. Grey Colors
  // =========================

  static const grey50 = Color(0xFFFAFAFA);
  static const grey100 = Color(0xFFF5F5F5);
  static const grey200 = Color(0xFFEEEEEE);
  static const grey300 = Color(0xFFE0E0E0);
  static const grey400 = Color(0xFFBDBDBD);
  static const grey500 = Color(0xFF9E9E9E);
  static const grey600 = Color(0xFF757575);
  static const grey700 = Color(0xFF616161);
  static const grey800 = Color(0xFF424242);
  static const grey900 = Color(0xFF212121);

  // =========================
  // 7. Special / UI Colors
  // =========================

  static const disabled = Color(0xFFBDBDBD);
  static const overlay = Color(0x80000000);
  static const shadow = Color(0x33000000);

  // =========================
  // 8. PetCare Specific Colors
  // =========================

  static const petBlue = Color(0xFF42A5F5);
  static const petGreen = Color(0xFF66BB6A);
  static const petOrange = Color(0xFFFFA726);
  static const petPurple = Color(0xFFAB47BC);
  static const petRed = Color(0xFFEF5350);

  static const vaccination = Color(0xFF42A5F5);
  static const appointment = Color(0xFFAB47BC);
  static const medication = Color(0xFF66BB6A);
  static const emergency = Color(0xFFEF5350);

  // =========================
  // 9. E-Commerce Colors
  // =========================

  static const price = Color(0xFFE53935);
  static const discount = Color(0xFFE53935);
  static const rating = Color(0xFFFFC107);
  static const sale = Color(0xFFFF5722);

  static const stockAvailable = Color(0xFF4CAF50);
  static const stockLow = Color(0xFFFFA000);
  static const outOfStock = Color(0xFF757575);

  static const favorite = Color(0xFFE91E63);
  static const cart = Color(0xFF4CAF50);

  // =========================
  // 10. Brand Colors
  // =========================

  static const tertiary = Color(0xFFE53935);
  static const quaternary = Color(0xFF9C27B0);
}