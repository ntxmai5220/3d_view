import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({
    Key? key,
    required this.content,
    this.type = DialogType.notification,
  }) : super(key: key);

  final String content;
  final DialogType type;

  @override
  Widget build(BuildContext context) {
    return DialogWrap(
        child: Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          Text(content, style: TextStyles.normalContent),
          const SizedBox(height: 15),
          ActionButton(
              label: 'Ok',
              labelColor: type.color,
              onTap: () => Navigator.pop(context, true))
        ],
      ),
    ));
  }
}
