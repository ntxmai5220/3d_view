import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class BottomSheetWrap extends StatelessWidget {
  const BottomSheetWrap({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(AppConstants.borderRadius * 2)),
      ),
      child: SafeArea(
        child: Wrap(
          children: [
            SizedBox(
              height: 24,
              child: Center(
                child: Container(
                  height: 2.5,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
