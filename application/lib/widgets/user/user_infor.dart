import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class UserInfor extends StatelessWidget {
  const UserInfor({
    Key? key,
    required this.user,
    this.onTapUser,
  }) : super(key: key);

  final User user;
  final Function(String)? onTapUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (user.id != null) {
          onTapUser?.call(user.id!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.pageMarginHorizontal),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 48,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:
                  user.username == null ? AppColors.lightSecondary45 : null,
              child: Text(
                user.username?[0].toUpperCase() ?? '',
                style: TextStyles.screenTitle.copyWith(color: AppColors.white),
              ),
              radius: 24,
            ),
            const SizedBox(width: 15),
            Expanded(
                child: user.username != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username ?? '',
                            style: TextStyles.buttonText.copyWith(
                              color: AppColors.darkPrimary,
                            ),
                          ),
                          Text(
                            '${user.posts?.length} bài viết',
                            style: TextStyles.tinyContent,
                          )
                        ],
                      )
                    : Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 100, 10),
                        decoration: BoxDecoration(
                            color: AppColors.lightSecondary45,
                            borderRadius: BorderRadius.circular(
                                AppConstants.borderRadius)),
                      )),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.darkPrimary,
            )
          ],
        ),
      ),
    );
  }
}
