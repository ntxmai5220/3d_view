import 'package:bk_3d_view/values/app_colors.dart';
import 'package:flutter/material.dart';

class BackLeading extends StatelessWidget {
  const BackLeading({
    Key? key,
    this.color,
  }) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 24,
          color: color ?? AppColors.white,
        ));
  }
}
