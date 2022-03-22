import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  const InputLabel(
      {Key? key, required this.label, this.isRequired = false, this.fontSize})
      : super(key: key);
  final String label;
  final bool isRequired;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: AppStyles.buttonText
              .copyWith(color: AppColors.darkSecondary, fontSize: fontSize),
          children: [
            TextSpan(text: label),
            TextSpan(
                text: isRequired ? ' *' : '',
                style: AppStyles.buttonText
                    .copyWith(color: AppColors.red, fontSize: 24))
          ]),
    );
  }
}
