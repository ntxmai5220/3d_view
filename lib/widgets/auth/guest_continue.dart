import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class GuestContinue extends StatelessWidget {
  final Function()? tap;
  const GuestContinue(this.tap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Tiếp tục với tư cách khách',
              style: AppStyles.normalLabel,
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: AppColors.darkSecondary,
            )
          ],
        ),
      ),
    );
  }
}
