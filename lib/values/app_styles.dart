import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const screenTitle = TextStyle(
    fontFamily: AppFonts.secondary,
    color: AppColors.darkSecondary,
    fontWeight: FontWeight.w700,
    fontSize: 27,
    letterSpacing: 0.02,
  );

  static const tinyLabel = TextStyle(
      fontFamily: AppFonts.primary,
      color: AppColors.darkSecondary,
      fontWeight: FontWeight.w600,
      fontSize: 14.5);

  static const tinyContent = TextStyle(
      fontFamily: AppFonts.primary,
      color: AppColors.darkSecondary,
      fontWeight: FontWeight.w500,
      fontSize: 14.5);

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
    fontSize: 16.5,
  );

  static const normalLabel = TextStyle(
      fontFamily: AppFonts.primary,
      color: AppColors.darkSecondary,
      fontWeight: FontWeight.w600,
      fontSize: 16.5);

  static const selectedTab = TextStyle(
      fontFamily: AppFonts.primary,
      color: AppColors.darkPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 12);

  static const unselectedTab = TextStyle(
      fontFamily: AppFonts.primary,
      color: AppColors.secondary,
      fontWeight: FontWeight.w500,
      fontSize: 11);

  static const labelTopic = TextStyle(
      fontFamily: AppFonts.secondary,
      color: AppColors.darkPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 20);

  //box decoration
  static const borderSide = BorderSide(color: AppColors.lightPrimary, width: 2);
  // static final border = Border.all(color: AppColors.lightPrimary, width: 1);
  //(left: borderSide, top: borderSide, right: borderSide)
  static const managePostIndicator = BoxDecoration(
    // gradient: LinearGradient(colors: [
    //   // AppColors.darkPrimary,
    //   AppColors.primary,
    //   Colors.blue.shade700
    // ]),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppConstants.borderRadius),
        topRight: Radius.circular(AppConstants.borderRadius)),
    color: AppColors.background,
  );
}
