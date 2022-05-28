import 'package:bk_3d_view/pages/login/login_page.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginRequired extends StatelessWidget {
  const LoginRequired({Key? key}) : super(key: key);

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
              color: AppColors.yellow,
              size: size.width / 3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Bạn cần đăng nhập\nđể sử dụng tính năng này',
            style:
                TextStyles.buttonText.copyWith(color: AppColors.darkSecondary),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.pageMarginHorizontal,
            ),
            child: MyButton('Đăng nhập',
                bgColor: AppColors.primary,
                onClick: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LoginPage()))),
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}
