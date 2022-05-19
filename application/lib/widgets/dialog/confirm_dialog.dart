import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/button/action_button.dart';
import 'package:bk_3d_view/widgets/button/icon_action_button.dart';
import 'package:bk_3d_view/widgets/dialog/dialog_wrap.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    required this.content,
    this.noLabel,
    this.noLabelColor,
    this.yesLabel,
  }) : super(key: key);

  final String content;
  final String? noLabel;
  final Color? noLabelColor;
  final String? yesLabel;
  @override
  Widget build(BuildContext context) {
    return DialogWrap(
        child: Column(
      children: [
        // const SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconActionButton(
              icon: Icons.close,
              iconColor: AppColors.secondary,
              size: 18,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        // const SizedBox(height: 5),
        Wrap(children: [Text(content, style: TextStyles.normalContent)]),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(
                label: noLabel ?? 'Không',
                labelColor: noLabelColor ?? AppColors.darkPrimary,
                onTap: () => Navigator.of(context).pop(false)),
            ActionButton(
              label: yesLabel ?? 'Có',
              labelColor: AppColors.darkPrimary,
              onTap: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    ));
  }
}
