import 'package:bk_3d_view/values/app_styles.dart';
import 'package:flutter/cupertino.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.label,
    this.labelStyle = TextStyles.tinyLabel,
    this.labelColor,
    this.background,
    this.padding = 0,
    this.onTap,
  }) : super(key: key);
  final String label;
  final TextStyle labelStyle;
  final Color? labelColor;
  final Color? background;
  final double padding;

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: background,
        padding: EdgeInsets.symmetric(
            vertical: 5 + padding, horizontal: 8 + padding),
        minSize: 25 + padding,
        child: Text(
          label,
          style: labelStyle.copyWith(color: labelColor),
        ),
        onPressed: onTap);
  }
}
