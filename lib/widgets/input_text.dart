import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class MyInputText extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final bool pw;
  const MyInputText(
      {Key? key,
      required this.hint,
      required this.controller,
      this.validator,
      this.pw = false})
      : super(key: key);

  @override
  _MyInputTextState createState() => _MyInputTextState();
}

class _MyInputTextState extends State<MyInputText> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.pw ? TextInputAction.done : TextInputAction.next,
      validator: widget.validator,
      controller: widget.controller,
      style: AppStyles.normalContent,
      obscureText: widget.pw && !isVisible,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textfieldBg,
        hintText: widget.hint,
        hintStyle: AppStyles.normalContent
            .copyWith(color: AppColors.darkSecondary.withOpacity(0.7)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
        suffixIcon: widget.pw
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Icon(
                  isVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.darkSecondary,
                ),
              )
            : null,
        border: const OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppConstants.borderRadis)),
            borderSide: BorderSide.none),
        errorStyle: AppStyles.tinyContent.copyWith(color: AppColors.red),
        // errorBorder: const OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(5)),
        //     borderSide: BorderSide(color: AppColor.iconColor)),
      ),
    );
  }
}
