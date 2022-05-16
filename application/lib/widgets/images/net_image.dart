import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

@immutable
class NetImage extends StatelessWidget {
  const NetImage({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.mini = false,
  }) : super(key: key);

  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  final bool mini;

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
      placeholder: (context, url) => LoadingPlaceHolder(
        width: width,
        height: height,
        mini: mini,
      ),
      errorWidget: (context, url, error) => LoadingPlaceHolder(
        width: width,
        height: height,
        mini: mini,
      ),
    );
  }
}
