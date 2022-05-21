import 'package:bk_3d_view/values/app_assets.dart';
import 'package:bk_3d_view/values/app_colors.dart';

import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
    this.content,
  }) : super(key: key);

  final String? content;
  // @override
  // Widget build(BuildContext context) {
  //   return Dialog(
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 23),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const SizedBox(height: 5),
  //           const SizedBox.square(
  //               dimension: 28, child: CircularProgressIndicator()),
  //           const SizedBox(height: 20),
  //           Text(content ?? 'Đang xử lý...',
  //               style: Theme.of(context).textTheme.bodyMedium),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      padding: EdgeInsets.all(
          (orientation == Orientation.portrait ? size.width : size.height) /
              2.7),
      child: SizedBox.square(
        dimension:
            (orientation == Orientation.portrait ? size.width : size.height) /
                3.5,
        child: Image.asset(AppAssets.appGif),
      ),
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.54),
        // image: const DecorationImage(image: AssetImage(AppAssets.appGif))
      ),
    );
  }
}
