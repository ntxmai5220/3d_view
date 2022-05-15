import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    Key? key,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  final PanoramActionType type;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 50,
      height: 50,
      child: FloatingActionButton(
        heroTag: type.text,
        backgroundColor: type.backgroundColor,
        onPressed: onTap,
        child: Icon(
          type.icon,
          // size: 28,
          color: type.iconColor,
        ),
        // label: const SizedBox(),
      ),
    );
  }
}
