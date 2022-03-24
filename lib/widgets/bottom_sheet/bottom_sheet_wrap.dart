import 'package:bk_3d_view/values/app_colors.dart';
import 'package:flutter/material.dart';

class BottomSheetWrap extends StatelessWidget {
  const BottomSheetWrap({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          SizedBox(
            height: 24,
            child: Center(
              child: Container(
                height: 4,
                width: 96,
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
    );
  }
}
