import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(this.label,
      {Key? key,
      required this.bgColor,
      required this.onClick,
      this.textColor = Colors.white})
      : super(key: key);
  final Color bgColor;
  final Color? textColor;
  final Function()? onClick;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppStyles.buttonText.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: bgColor,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
