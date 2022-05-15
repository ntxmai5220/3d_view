import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/values/values.dart';
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
  }) : super(key: key);

  final List<dynamic> list;
  final String? title;
  final Function(String)? onToggleFavorite;
  final Function(String)? onTapPost;
  final Color backgroundColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? Container(
            color: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                title != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.pageMarginHorizontal,
                        ),
                        child: Text(
                          title!,
                          style:
                              TextStyles.labelTopic.copyWith(color: titleColor),
                        ),
                      )
                    : const SizedBox(
                        height: AppConstants.pageMarginHorizontal / 2),
                SizedBox(
                  height: 343,
                  child: GridView.builder(
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
                            post: posts[index],
                            onTapPost: onTapPost,
                            onToggleFavorite: onToggleFavorite,
                          )),
                ),
                const SizedBox(height: 7),
              ],
            ),
          )
        : const SizedBox();
  }
}
