import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/button/action_button.dart';
import 'package:bk_3d_view/widgets/dialog/dialog_wrap.dart';
import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    Key? key,
    required this.content,
    this.noLabel,
    this.yesLabel,
  }) : super(key: key);

  final String content;
  final String? noLabel;
  final String? yesLabel;
  @override
  Widget build(BuildContext context) {
    return DialogWrap(
        child: Column(
      children: [
        const SizedBox(height: 5),
        Row(
          children: [
            Spacer(
              flex: 9,
            ),
            Text(content, style: TextStyles.normalContent),
            Spacer(
              flex: 8,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.close,
                size: 18,
                color: AppColors.secondary,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(
                label: noLabel ?? 'Không',
                labelColor: AppColors.darkPrimary,
                onTap: () => Navigator.of(context).pop(false)),
            ActionButton(
              label: yesLabel ?? 'Có',
              labelColor: AppColors.darkPrimary,
              onTap: () => Navigator.of(context).pop(true),
            ),
          ],
        )
      ],
    ));
  }
}
