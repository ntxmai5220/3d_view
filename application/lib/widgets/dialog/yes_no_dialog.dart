import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/button/action_button.dart';
import 'package:bk_3d_view/widgets/dialog/dialog_wrap.dart';
import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return DialogWrap(
        child: Column(
      children: [
        const SizedBox(height: 5),
        Text(content, style: TextStyles.normalContent),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(
                label: 'Không', onTap: () => Navigator.of(context).pop(false)),
            ActionButton(
              label: 'Có',
              labelColor: AppColors.darkPrimary,
              onTap: () => Navigator.of(context).pop(false),
            ),
          ],
        )
      ],
    ));
  }
}
