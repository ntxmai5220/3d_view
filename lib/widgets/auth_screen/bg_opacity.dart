import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class BgOpacity extends StatelessWidget {
  const BgOpacity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      height: 200,
      width: 500,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(AppColors.white80, BlendMode.srcOver),
              image: AssetImage(AppAssets.background),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
