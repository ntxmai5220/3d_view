import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class FollowIcon extends StatelessWidget {
  const FollowIcon({
    Key? key,
    required this.isFollowed,
    this.mini = false,
  }) : super(key: key);

  final bool isFollowed;
  final bool mini;
  @override
  Widget build(BuildContext context) {
    return isFollowed
        ? Icon(
            Icons.star_rounded,
            // Icons.star_border_rounded,
            size: mini ? 27 : 30,
            color: AppColors.yellow,
          )
        : Icon(
            // Icons.star_rounded,
            Icons.star_border_rounded,
            size: mini ? 27 : 30,
            color: Colors.white,
          );
  }
}
