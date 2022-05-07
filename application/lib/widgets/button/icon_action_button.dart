import 'package:flutter/cupertino.dart';

class IconActionButton extends StatelessWidget {
  const IconActionButton({
    Key? key,
    this.iconColor,
    required this.icon,
    this.background,
    this.padding = 0,
    this.size,
    this.onTap,
  }) : super(key: key);

  final Color? iconColor;
  final IconData icon;
  final Color? background;
  final double padding;
  final double? size;

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: background,
        padding: EdgeInsets.symmetric(
            vertical: 8 + padding, horizontal: 8 + padding),
        minSize: 25 + padding,
        child: Icon(
          icon,
          color: iconColor,
          size: size,
        ),
        onPressed: onTap);
  }
}
