import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PickImageDialog extends StatelessWidget {
  const PickImageDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogWrap(
        child: Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Bạn cần tải ảnh lên',
              style: TextStyles.normalContent),
          const SizedBox(height: 15),
          ActionButton(
              label: 'Ok',
              labelColor: AppColors.primary,
              onTap: () => Navigator.pop(context, true))
        ],
      ),
    ));
  }
}
