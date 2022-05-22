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
      style: TextStyles.normalContent,
      obscureText: widget.pw && !isVisible,
      cursorColor: AppColors.darkSecondary,
      decoration: InputDecoration(
        helperText: '',
        helperStyle: TextStyles.tinyContent.copyWith(color: AppColors.red),
        filled: true,
        fillColor: AppColors.textfieldBg,
        hintText: widget.hint,
        hintStyle: TextStyles.normalContent
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
                BorderRadius.all(Radius.circular(AppConstants.borderRadius)),
            borderSide: BorderSide.none),
        errorStyle: TextStyles.tinyContent.copyWith(color: AppColors.red),
        // errorBorder: const OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(5)),
        //     borderSide: BorderSide(color: AppColor.iconColor)),
      ),
    );
  }
}
