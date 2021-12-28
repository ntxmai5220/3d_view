import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const screenTitle = TextStyle(
    fontFamily: AppFonts.secondary,
    color: AppColors.darkSecondary,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: 0.02,
  );

  static const tinyLabel = TextStyle(
      fontFamily: AppFonts.primary,
      color: AppColors.darkSecondary,
      fontWeight: FontWeight.w600,
      fontSize: 15);

  static const tinyContent = TextStyle(
      fontFamily: AppFonts.primary,
      color: AppColors.darkSecondary,
      fontWeight: FontWeight.w500,
      fontSize: 15);

  static const buttonText = TextStyle(
    fontFamily: AppFonts.primary,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    letterSpacing: 0.02,
  );

  static const normalContent = TextStyle(
      fontFamily: AppFonts.primary,
      color: AppColors.darkSecondary,
      fontWeight: FontWeight.w500,
      fontSize: 16.5);

  static const normalLabel = TextStyle(
      fontFamily: AppFonts.primary,
      color: AppColors.darkSecondary,
      fontWeight: FontWeight.w600,
      fontSize: 16.5);
}
