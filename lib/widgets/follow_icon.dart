import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class FollowIcon extends StatelessWidget {
  const FollowIcon({Key? key, required this.isFollowed}) : super(key: key);
  final bool isFollowed;
  @override
  Widget build(BuildContext context) {
    return isFollowed
        ? const Icon(
            Icons.star_rounded,
            // Icons.star_border_rounded,
            size: 30,
            color: AppColors.yellow,
          )
        : const Icon(
            // Icons.star_rounded,
            Icons.star_border_rounded,
            size: 30,
            color: Colors.white,
          );
  }
}
