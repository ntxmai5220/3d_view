import 'package:bk_3d_view/values/app_enum.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:flutter/material.dart';

class ExtendFloatingButton extends StatelessWidget {
  const ExtendFloatingButton({
    Key? key,
    required this.type,
    required this.currentType,
    required this.onTap,
    required this.isExtend,
  }) : super(key: key);

  final PanoramActionType type;
  final PanoramActionType currentType;
  final Function() onTap;
  final bool isExtend;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: isExtend ? 165 : 50,
      height: 50,
      child: FloatingActionButton.extended(
        heroTag: "Extend ${isExtend ? 165 : 50} $type",
        backgroundColor: type == currentType
            ? type.backgroundColor
            : PanoramActionType.none.backgroundColor,
        onPressed: onTap,
        icon: Padding(
          padding: EdgeInsets.only(left: isExtend ? 0 : 12, top: 1),
          child: Icon(
            // currentType == type ? PanoramActionType.none.icon : type.icon,
            type.icon,
            color: type == currentType
                ? type.iconColor
                : PanoramActionType.none.iconColor,
          ),
        ),
        label: isExtend
            ? Text(
                type.text,
                style: TextStyles.normalLabel.copyWith(
                    color: type == currentType
                        ? type.iconColor
                        : PanoramActionType.none.iconColor),
              )
            : const SizedBox(),
      ),
    );
  }
}
