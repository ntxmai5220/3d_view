import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class MSquare extends StatelessWidget {
  const MSquare({Key? key, this.content, this.style}) : super(key: key);
  final String? content;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style:
              style ?? TextStyles.normalLabel.copyWith(color: AppColors.black),
          children: [
            TextSpan(text: '${content ?? ''} m'),
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(2, -8),
                child: Text(
                  '2',
                  style: style ??
                      TextStyles.normalLabel.copyWith(color: AppColors.black),
                  textScaleFactor:
                      0.75, //superscript is usually smaller in size
                ),
              ),
            )
          ]),
    );
  }
}
