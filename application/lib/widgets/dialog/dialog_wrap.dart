import 'package:flutter/material.dart';

class DialogWrap extends StatelessWidget {
  const DialogWrap({
    Key? key,
    required this.child,
    this.bgColor,
  }) : super(key: key);
  final Widget child;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: bgColor,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Wrap(
          children: [child],
        ),
      ),
    );
  }
}
