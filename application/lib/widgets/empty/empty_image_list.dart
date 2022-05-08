import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/button/action_button.dart';
import 'package:flutter/material.dart';

class EmptyImageList extends StatelessWidget {
  const EmptyImageList({
    Key? key,
    this.onBackUploadImage,
    this.content,
  }) : super(key: key);

  final VoidCallback? onBackUploadImage;
  final String? content;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.photo_library_outlined,
              size: 85,
              color: AppColors.secondary,
            ),
            const SizedBox(height: 17),
            Text(
              content ?? 'Bạn chưa có ảnh',
              textAlign: TextAlign.center,
              style: TextStyles.buttonText.copyWith(color: AppColors.secondary),
            ),
            const SizedBox(height: 12),
            onBackUploadImage != null
                ? ActionButton(
                    label: 'Tải ảnh lên',
                    onTap: onBackUploadImage,
                    labelColor: AppColors.darkPrimary,
                    labelStyle: TextStyles.normalLabel,
                    background: AppColors.lightSecondary,
                    padding: 10,
                  )
                : const SizedBox()
          ],
        ),
      ],
    );
  }
}
