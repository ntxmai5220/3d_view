import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetBar extends StatelessWidget {
  const BottomSheetBar({
    Key? key,
    required this.title,
    this.leading,
    this.trailing,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text(
        title,
        style: AppStyles.buttonText.copyWith(color: AppColors.darkSecondary),
        // style: TextStyles.pangram.boldTitle.copyWith(
        //   color: AppColors.charcoal,
        // ),
      ),
      // backgroundColor: AppColors.babyPowder,
      border: null,
      leading: leading ??
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close_rounded,
              color: AppColors.secondary,
            ),
          ),
      trailing: trailing,
    );
  }
}
