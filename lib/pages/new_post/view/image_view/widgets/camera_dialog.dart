import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CameraDialog extends StatelessWidget {
  const CameraDialog({Key? key, this.onTapContinue, this.onTapCancel})
      : super(key: key);

  final VoidCallback? onTapContinue;
  final VoidCallback? onTapCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      actionsPadding: const EdgeInsets.all(8),
      title: const Text(
          'Để chụp ảnh panorama bạn cần tải và cài đặt Google Camera, bắt đầu tải xuống?'),
      content: Image.asset(AppAssets.ggCamera, height: 45),
      actions: [
        ActionButton(
          label: 'Không',
          padding: 5,
          onTap: () {
            if (onTapCancel != null) onTapCancel!();
            Navigator.pop(context, false);
          },
        ),
        ActionButton(
            label: 'Có',
            labelColor: AppColors.primary,
            padding: 5,
            onTap: () {
              if (onTapContinue != null) onTapContinue!();
              Navigator.pop(context, true);
            }),
      ],
    );
  }
}
