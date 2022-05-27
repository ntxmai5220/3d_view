import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/button/icon_action_button.dart';
import 'package:bk_3d_view/widgets/images/loading_placeholder.dart';
import 'package:bk_3d_view/widgets/scroll/custom_scroll.dart';
import 'package:flutter/material.dart';

import '../post_item.dart';

class HorizontalListMiniPost2 extends StatelessWidget {
  const HorizontalListMiniPost2({
    Key? key,
    this.list = const [],
    this.title,
    this.onToggleFavorite,
    this.onTapPost,
    this.backgroundColor = Colors.transparent,
    this.titleColor = AppColors.darkPrimary,
    this.onMoreTap,
  }) : super(key: key);

  final List<Post> list;
  final String? title;
  final Function(String)? onToggleFavorite;
  final Function(String)? onTapPost;
  final Color backgroundColor;
  final Color titleColor;
  final Function()? onMoreTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          title != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.pageMarginHorizontal,
                      ),
                      child: Text(
                        title!,
                        style:
                            TextStyles.labelTopic.copyWith(color: titleColor),
                      ),
                    ),
                    onMoreTap != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: IconActionButton(
                              onTap: onMoreTap,
                              icon: Icons.keyboard_arrow_right_rounded,
                              // background: Colors.black54,
                              size: 28,
                              iconColor: AppColors.darkPrimary,
                            ),
                          )
                        : const SizedBox(height: 38)
                  ],
                )
              : const SizedBox(height: AppConstants.pageMarginHorizontal / 2),
          list.isNotEmpty
              ? SizedBox(
                  height: 343,
                  child: GridView.builder(
                      physics: const CustomScrollPhysics(itemDimension: 321),
                      itemCount: list.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.pageMarginHorizontal,
                          vertical: 5),
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 18,
                              crossAxisCount: 1,
                              childAspectRatio: 1.1),
                      itemBuilder: (context, index) => PostItem(
                            mini: true,
                            post: list[index],
                            onTapPost: onTapPost,
                            onToggleFavorite: onToggleFavorite,
                          )),
                )
              : Center(
                  child: LoadingPlaceHolder(
                      width: size.width > 343 ? 343 : size.width, height: 343),
                ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}
