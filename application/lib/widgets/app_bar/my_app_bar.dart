import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    Key? key,
    Color? backgroundColor,
    Color? color,
    required Widget title,
    Widget? leading,
    List<Widget>? actions,
    bool centerTitle = true,
  }) : super(
            key: key,
            title: title,
            centerTitle: centerTitle,
            elevation: 0,
            backgroundColor: backgroundColor ?? AppColors.darkPrimary,
            leading: leading ?? const BackLeading(),
            actions: actions,
            automaticallyImplyLeading: false);
}
