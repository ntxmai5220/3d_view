import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

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
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}
