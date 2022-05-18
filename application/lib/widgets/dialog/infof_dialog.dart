import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InforDialog extends StatelessWidget {
  const InforDialog({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return DialogWrap(
        bgColor: Colors.black.withOpacity(0.75),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconActionButton(
                    icon: Icons.close_rounded,
                    size: 18,
                    iconColor: AppColors.white80,
                    onTap: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              Text(content,
                  style: TextStyles.normalContent
                      .copyWith(color: AppColors.white)),
              const SizedBox(height: 15),
            ],
          ),
        ));
  }
}
