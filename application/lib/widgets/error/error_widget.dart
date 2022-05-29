import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_enum.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/button/my_button.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    Key? key,
    this.content,
    this.onTap,
  }) : super(key: key);
  final String? content;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.pageMarginHorizontal,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Icon(
              Icons.warning_amber_rounded,
              color: AppColors.red.withOpacity(0.7),
              size: size.width / 3.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content ?? ValidatorError.defaultError.error,
            style:
                TextStyles.buttonText.copyWith(color: AppColors.darkSecondary),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.pageMarginHorizontal,
            ),
            child:
                MyButton('Tải lại', bgColor: AppColors.primary, onClick: onTap),
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}
