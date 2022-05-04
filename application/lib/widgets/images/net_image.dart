import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

@immutable
class NetImage extends StatelessWidget {
  const NetImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      // progressIndicatorBuilder:
      //     (context, url, DownloadProgress downloadProgress) {
      //   debugPrint(downloadProgress.progress.toString());
      //   return Container(
      //     width: width,
      //     height: height,
      //     child: Center(
      //       child: CircularProgressIndicator(
      //         value: downloadProgress.progress,
      //       ),
      //     ),
      //   );
      // },
      filterQuality: FilterQuality.medium,
      placeholderFadeInDuration: const Duration(milliseconds: 700),
      placeholder: (context, url) => SizedBox(
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
          )),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        // color: AppColors.background,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
