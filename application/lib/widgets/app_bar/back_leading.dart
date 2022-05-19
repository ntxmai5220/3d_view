import 'package:bk_3d_view/values/app_colors.dart';
import 'package:flutter/material.dart';

class BackLeading extends StatelessWidget {
  const BackLeading({
    Key? key,
    this.color,
    this.onTap,
  }) : super(key: key);

  final Color? color;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ?? () => Navigator.of(context).pop(),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 24,
          color: color ?? AppColors.white,
        ));
  }
}
