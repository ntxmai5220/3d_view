import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class AppBarTextTitle extends StatelessWidget {
  const AppBarTextTitle({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);

  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyles.screenTitle
            .copyWith(color: color ?? AppColors.darkPrimary));
  }
}
