import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Divider(
            thickness: 0.8,
            color: AppColors.darkSecondary,
            endIndent: 12,
          ),
        ),
        Text(
          'hoặc',
          style: AppStyles.normalContent,
        ),
        Expanded(
          child: Divider(
            thickness: 0.8,
            color: AppColors.darkSecondary,
            indent: 12,
          ),
        ),
      ],
    );
  }
}
