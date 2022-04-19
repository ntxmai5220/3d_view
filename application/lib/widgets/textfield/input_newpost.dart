import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/text/input_label.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputNewPost extends StatelessWidget {
  const InputNewPost({
    Key? key,
    required this.controller,
    required this.label,
    this.isRequired = false,
    this.suffixText,
    this.inputNumber = false,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final bool isRequired;
  final String? suffixText;
  final bool inputNumber;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        keyboardType: inputNumber ? TextInputType.number : TextInputType.text,
        controller: controller,
        style: TextStyles.normalContent,
        cursorColor: AppColors.darkSecondary,
        decoration: InputDecoration(
          // labelText: label,
          label: InputLabel(label: label, isRequired: isRequired),
          labelStyle: TextStyles.normalLabel,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyles.normalLabel,
          // suffixText: 'triệu',
          suffixStyle: TextStyles.normalContent,
          suffixIcon: SizedBox(
            child: Center(
              widthFactor: 0.0,
              child: suffixText == 'm2'
                  ? MSquare(
                      style: TextStyles.tinyContent
                          .copyWith(color: AppColors.secondary),
                    )
                  : Text(
                      suffixText ?? '',
                      style: TextStyles.tinyContent
                          .copyWith(color: AppColors.secondary),
                    ),
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 5, 1.5),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary),
              borderRadius:
                  BorderRadius.all(Radius.circular(AppConstants.borderRadius))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary),
              borderRadius:
                  BorderRadius.all(Radius.circular(AppConstants.borderRadius))),
        ),
      ),
    );
  }
}
