import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class ChooseItem extends StatelessWidget {
  final String label;
  final Function()? onClick;
  const ChooseItem(this.label, {Key? key, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.lightSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      // margin: const EdgeInsets.symmetric(
      //     horizontal: AppConstants.pageMarginHorizontal),
      elevation: AppConstants.cardElevation * 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        onTap: onClick,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 10),
          // padding: const EdgeInsets.symmetric(vertical: 15),
          height: 46,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // child: Text(
                //   label,
                //   style: TextStyles.normalContent,
                //   maxLines: null,
                //   softWrap: true,
                // ),
                child: Text(
                  label,
                  style: TextStyles.normalContent,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.darkPrimary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
