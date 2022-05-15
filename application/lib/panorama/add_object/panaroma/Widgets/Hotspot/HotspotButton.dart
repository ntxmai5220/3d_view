
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:flutter/material.dart';

Widget hotspotButton({String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(icon),
          onPressed: onPressed,
        ),
        text != null
            ? Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(child: Text(text, style: TextStyles.normalLabel.copyWith(color: AppColors.white),)),
              )
            : Container(),
      ],
    );
  }