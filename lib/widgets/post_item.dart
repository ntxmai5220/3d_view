import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.post,
    this.onClick,
    this.onToggleFavorite,
  }) : super(key: key);

  final Post post;
  final VoidCallback? onClick;
  final VoidCallback? onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.pageMarginHorizontal,
            vertical: AppConstants.pageMarginHorizontal / 2),
        height: 380,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightSecondary),
            borderRadius: const BorderRadius.all(
                Radius.circular(AppConstants.borderRadius))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
              Radius.circular(AppConstants.borderRadius)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //stack for image & follow
              Stack(
                children: [
                  Container(
                    height: 267,
                    // color: AppColors.lightPrimary,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(post.rooms?[0].img ?? ''),
                            fit: BoxFit.cover)),
                  ),
                  onToggleFavorite != null
                      ? Positioned(
                          right: 20,
                          child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              height: 60,
                              width: 51,
                              decoration: const BoxDecoration(
                                  color: AppColors.lightSecondary88,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(
                                          AppConstants.borderRadius))),
                              child: GestureDetector(
                                  onTap: onToggleFavorite,
                                  child: FollowIcon(
                                    isFollowed: post.isFavorite ?? false,
                                  ))))
                      : Container(),
                ],
              ),
              //column for detail
              Expanded(
                  child: Container(
                // alignment: Alignment.center,
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ' + checkPrice(post.price ?? 0),
                          style: AppStyles.normalLabel
                              .copyWith(color: AppColors.black),
                        ),
                        MSquare(content: post.area.toString()),
                      ],
                    ),
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Địa chỉ: ',
                          style: AppStyles.tinyLabel
                              .copyWith(color: AppColors.black),
                        ),
                        TextSpan(
                          text:
                              '${post.address}, ${post.ward?.name ?? ''}, ${post.district?.name ?? ''}, ${post.province?.name ?? ''}',
                          style: AppStyles.tinyContent
                              .copyWith(color: AppColors.darkSecondary),
                        ),
                      ]),
                    ),
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Mô tả: ',
                          style: AppStyles.tinyLabel
                              .copyWith(color: AppColors.black),
                        ),
                        TextSpan(
                          text: '${post.desc} ' * 10,
                          style: AppStyles.tinyContent
                              .copyWith(color: AppColors.darkSecondary),
                        ),
                      ]),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  String checkPrice(double price) {
    if (price > 1000) {
      double tmp = price / 1000;
      return '$tmp tỷ';
    } else {
      return '$price triệu';
    }
  }
}
