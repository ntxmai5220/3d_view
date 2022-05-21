import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class LoadingPlaceHolder extends StatelessWidget {
  const LoadingPlaceHolder({
    Key? key,
    required this.width,
    required this.height,
    this.mini = false,
  }) : super(key: key);

  final double width;
  final double height;

  final bool mini;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppAssets.appLogo,
                  height: mini ? 30 : 60,
                  width: mini ? 30 : 60,
                ),
                SizedBox(height: mini ? 5 : 15),
                Text(
                  '3D VIEW',
                  textAlign: TextAlign.center,
                  style: TextStyles.labelTopic.copyWith(
                      color: AppColors.darkPrimary, fontSize: mini ? 12 : 20),
                )
              ],
            ),
            Positioned.fill(
                child: Container(
              color: Colors.transparent,
            ))
          ],
        ));
  }
}
