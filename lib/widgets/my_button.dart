import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color bgColor;
  final Function()? onClick;
  final String label;
  const MyButton(this.label,
      {Key? key, required this.bgColor, required this.onClick})
      : super(key: key);

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
              color: bgColor == AppColors.primary || bgColor == AppColors.red
                  ? Colors.white
                  : AppColors.primary,
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
