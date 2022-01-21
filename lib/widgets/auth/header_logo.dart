import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  final String screen;
  const HeaderLogo(this.screen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                screen,
                style: AppStyles.screenTitle,
              ),
              RichText(
                text: TextSpan(
                  text: 'Chào mừng đến với ',
                  style: AppStyles.tinyLabel,
                  children: <TextSpan>[
                    TextSpan(
                      text: '3D VIEW',
                      style: AppStyles.buttonText
                          .copyWith(color: AppColors.primary),
                      // recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          AppAssets.appLogo,
          height: AppConstants.logoSize,
          width: AppConstants.logoSize,
        )
      ],
    );
  }
}
