import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class LoadingPlaceHolder extends StatelessWidget {
  const LoadingPlaceHolder({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
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
                  height: 60,
                  width: 60,
                ),
                const SizedBox(height: 15),
                Text(
                  '3D VIEW',
                  textAlign: TextAlign.center,
                  style: TextStyles.labelTopic
                      .copyWith(color: AppColors.darkPrimary),
                )
              ],
            ),
            Positioned.fill(
                child: Container(
              color: AppColors.white80,
            ))
          ],
        ));
  }
}
