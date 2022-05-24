import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.post,
    this.onTapPost,
    this.onToggleFavorite,
    this.mini = false,
  }) : super(key: key);

  final Post post;
  final Function(String)? onTapPost;
  final Function(String)? onToggleFavorite;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    var id = post.id;
    return GestureDetector(
      onTap: () {
        if (id != null) {
          onTapPost?.call(id);
        }
      },
      child: Container(
        height: 380,
        width: 380,
        decoration: BoxDecoration(
            // boxShadow: const [
            //   BoxShadow(
            //       offset: Offset(0, 0),
            //       blurRadius: 5,
            //       spreadRadius: 1,
            //       color: AppColors.lightSecondary45)
            // ],
            border: Border.all(color: AppColors.lightSecondary),
            borderRadius: const BorderRadius.all(
                Radius.circular(AppConstants.borderRadius + 1))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
              Radius.circular(AppConstants.borderRadius)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //stack for image & follow
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: NetImage(
                        imageUrl: post.rooms?[0].imgUrl ?? '',
                        height: mini ? 228 : 260,
                        width: 380,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Container(
                    //   // height: mini ? 225 : 260,
                    //   // color: AppColors.lightPrimary,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(post.rooms?[0].imgUrl ?? ''),
                    //           fit: BoxFit.cover)),
                    // ),
                    onToggleFavorite != null
                        ? Positioned(
                            right: 20,
                            child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              height: mini ? 55 : 59,
                              width: mini ? 45 : 49,
                              decoration: const BoxDecoration(
                                  color: AppColors.lightSecondary88,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(
                                          AppConstants.borderRadius))),
                              child: GestureDetector(
                                onTap: () {
                                  if (id != null) {
                                    onToggleFavorite?.call(id);
                                  }
                                },
                                child: FollowIcon(
                                  mini: mini,
                                  isFollowed: post.isFavorite ?? false,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              //column for detail
              Container(
                height: mini ? 380 - 260 : null,
                // alignment: Alignment.center,
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ' + checkPrice(post.price ?? 0),
                          style: TextStyles.normalLabel
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
                          style: TextStyles.tinyLabel
                              .copyWith(color: AppColors.black),
                        ),
                        TextSpan(
                          text:
                              '${post.address}, ${post.ward?.name ?? ''}, ${post.district?.name ?? ''}, ${post.province?.name ?? ''}',
                          style: TextStyles.tinyContent
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
                          style: TextStyles.tinyLabel
                              .copyWith(color: AppColors.black),
                        ),
                        TextSpan(
                          text: '${post.desc}',
                          style: TextStyles.tinyContent
                              .copyWith(color: AppColors.darkSecondary),
                        ),
                      ]),
                    ),
                  ],
                ),
              )
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
