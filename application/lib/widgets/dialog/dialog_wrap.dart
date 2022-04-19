import 'package:flutter/material.dart';

class DialogWrap extends StatelessWidget {
  const DialogWrap({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Wrap(
          children: [child],
        ),
      ),
    );
  }
}
