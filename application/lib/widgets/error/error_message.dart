import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
    this.content = '',
  }) : super(key: key);

  final String? content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Text(
          content!.isEmpty ? ValidatorError.defaultError.error : content!,
          maxLines: 2,
          style: TextStyles.tinyLabel.copyWith(color: AppColors.red),
        ),
      ),
    );
  }
}
